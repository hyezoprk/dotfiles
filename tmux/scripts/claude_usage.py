#!/usr/bin/env python3
"""
Fetch Claude Code usage via `claude /usage` with PTY.
Output: "45% 32%wk / 3pm Feb2 1pm"
"""
import pty, os, re, sys, time, select, signal, tempfile, shutil

CLAUDE = '/Users/hyezoprk/.local/bin/claude'
TIMEOUT = 30


def strip_ansi(s):
    return re.sub(r'\x1b(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])', '', s)


def fetch():
    tmpdir = tempfile.mkdtemp(prefix='claude-usage-')
    master, slave = pty.openpty()

    env = dict(
        PATH='/Users/hyezoprk/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin',
        HOME=os.environ.get('HOME', '/tmp'),
        USER=os.environ.get('USER', ''),
        TERM='dumb',
        NO_COLOR='1',
    )

    pid = os.fork()
    if pid == 0:
        os.close(master)
        os.setsid()
        import fcntl, termios
        fcntl.ioctl(slave, termios.TIOCSCTTY, 0)
        os.dup2(slave, 0); os.dup2(slave, 1); os.dup2(slave, 2)
        if slave > 2:
            os.close(slave)
        os.chdir(tmpdir)
        os.execve(CLAUDE, ['claude', '/usage'], env)
        os._exit(1)

    os.close(slave)
    buf = b''
    deadline = time.monotonic() + TIMEOUT
    found = False
    sent_trust = False

    while time.monotonic() < deadline:
        rem = deadline - time.monotonic()
        try:
            r, _, _ = select.select([master], [], [], min(rem, 0.3))
        except (ValueError, OSError):
            break
        if r:
            try:
                data = os.read(master, 4096)
            except OSError:
                break
            if not data:
                break
            buf += data
            text = strip_ansi(buf.decode('utf-8', errors='replace'))
            if not sent_trust and ('trust' in text.lower() or 'proceed' in text.lower()):
                sent_trust = True
                os.write(master, b'\r')
            if 'Current week (all models)' in text:
                found = True
        elif found:
            break

    try: os.kill(pid, signal.SIGKILL)
    except: pass
    try: os.waitpid(pid, 0)
    except: pass
    try: os.close(master)
    except: pass
    shutil.rmtree(tmpdir, ignore_errors=True)

    return buf.decode('utf-8', errors='replace') if found else ''


def parse(text):
    t = strip_ansi(text)

    def find_pct(s):
        m = re.search(r'(\d+)%', s)
        return m.group(1) if m else None

    def find_time(s):
        m = re.search(r'(\d{1,2}(?::\d{2})?)\s*([ap]m)', s, re.I)
        return f"{m.group(1)}{m.group(2).lower()}" if m else None

    s_pct = w_pct = s_reset = w_reset = None

    m = re.search(r'Current session(.*?)(?=Current week|\Z)', t, re.S | re.I)
    if m:
        s_pct = find_pct(m.group(1))
        s_reset = find_time(m.group(1))

    m = re.search(r'Current week \(all models\)(.*?)(?=\n\n|\Z)', t, re.S | re.I)
    if m:
        w_pct = find_pct(m.group(1))
        r = re.search(r'Resets?\s+(\w+)\s+(\d+)(?:\s+at\s+(\S+))?', m.group(1), re.I)
        if r:
            w_reset = f"{r.group(1)}{r.group(2)}"
            if r.group(3):
                w_reset += f" {r.group(3).lower()}"

    return s_pct, w_pct, s_reset, w_reset


if __name__ == '__main__':
    raw = fetch()
    if not raw:
        print('CC: ?')
        sys.exit(0)

    s_pct, w_pct, s_reset, w_reset = parse(raw)
    pcts = f"{s_pct or '?'}% {w_pct or '?'}%wk"
    resets = ' '.join(filter(None, [s_reset, w_reset]))
    print(f"{pcts} / {resets}" if resets else pcts)
