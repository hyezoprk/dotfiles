#!/usr/bin/env python3
"""
Fetch Claude Code usage via `claude /usage` with PTY.
Output: "75% 40%wk / 6:40pm Apr30 7pm"
"""
import pty, os, re, sys, time, select, signal

CLAUDE = '/Users/hyezoprk/.local/bin/claude'
TIMEOUT = 35
WORKSPACE = os.path.join(os.environ.get('HOME', '/tmp'), '.claude-usage-workspace')


def strip_ansi(s):
    return re.sub(r'\x1b(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])', '', s)


def fetch():
    os.makedirs(WORKSPACE, exist_ok=True)
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
        os.chdir(WORKSPACE)
        os.execve(CLAUDE, ['claude', '/usage'], env)
        os._exit(1)

    os.close(slave)
    buf = b''
    deadline = time.monotonic() + TIMEOUT
    found = False
    sent_trust = False
    last_data = time.monotonic()

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
            last_data = time.monotonic()
            text = strip_ansi(buf.decode('utf-8', errors='replace'))
            if not sent_trust and 'trust' in text.lower():
                sent_trust = True
                time.sleep(0.2)
                os.write(master, b'\r')
            if 'allmodels' in text.replace(' ', '').lower():
                found = True
        elif found and time.monotonic() - last_data > 0.8:
            break

    try: os.kill(pid, signal.SIGKILL)
    except: pass
    try: os.waitpid(pid, 0)
    except: pass
    try: os.close(master)
    except: pass

    return buf.decode('utf-8', errors='replace') if found else ''


def parse(raw):
    text = strip_ansi(raw)
    # \r로 나뉜 라인들을 \n으로 통일
    lines = [l.strip() for l in re.split(r'[\r\n]+', text) if l.strip()]
    joined = '\n'.join(lines)
    # 공백 제거 버전
    flat = joined.replace(' ', '')

    s_pct = w_pct = s_reset = w_reset = None

    # 세션 % — "Curr(e|e)tsession" 이후 첫 번째 NN%
    m = re.search(r'[Cc]urr.{0,3}session.*?(\d+)%', flat, re.S)
    if m:
        s_pct = m.group(1)

    # 세션 리셋 — "Reses" 또는 "Resets" 뒤의 시간 (weekly reset 이전)
    # flat에서 세션 영역: session ~ week 사이
    session_area = re.search(r'[Cc]urr.{0,3}session(.*?)(?=[Cc]urrentweek|\Z)', flat, re.S)
    if session_area:
        m = re.search(r'Rese.{0,2}(\d{1,2}(?::\d{2})?[ap]m)', session_area.group(1), re.I)
        if m:
            s_reset = m.group(1).lower()

    # 주간 % — "allmodels" 이후 첫 번째 NN%
    m = re.search(r'allmodels.*?(\d+)%', flat, re.S)
    if m:
        w_pct = m.group(1)

    # 주간 리셋 — "ResetsApr30at7pm" 형태
    m = re.search(r'Resets([A-Za-z]+)(\d+)at(\d{1,2}(?::\d{2})?[ap]m)', flat, re.I)
    if m:
        w_reset = f"{m.group(1)}{m.group(2)} {m.group(3).lower()}"

    return s_pct, w_pct, s_reset, w_reset


if __name__ == '__main__':
    raw = fetch()
    if not raw:
        print('?')
        sys.exit(0)

    s_pct, w_pct, s_reset, w_reset = parse(raw)
    pcts = f"{s_pct or '?'}% {w_pct or '?'}%wk"
    resets = ' '.join(filter(None, [s_reset, w_reset]))
    print(f"{pcts} / {resets}" if resets else pcts)
