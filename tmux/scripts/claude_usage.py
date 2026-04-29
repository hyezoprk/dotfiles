#!/usr/bin/env python3
"""
fetch 모드: claude /usage 실행 → 파이프 구분 raw 데이터를 stdout으로
display 모드: stdin에서 raw 데이터 읽어 남은 시간 계산 후 포맷 출력

캐시 구조: s_pct|s_reset_hhmm|w_pct|w_reset_mdhhmm
  예) 84|18:40|41|4/30 19:00
"""
import pty, os, re, sys, time, select, signal
from datetime import datetime, timedelta

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
        os.close(master); os.setsid()
        import fcntl, termios
        fcntl.ioctl(slave, termios.TIOCSCTTY, 0)
        os.dup2(slave, 0); os.dup2(slave, 1); os.dup2(slave, 2)
        if slave > 2: os.close(slave)
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
            if not data: break
            buf += data
            last_data = time.monotonic()
            text = strip_ansi(buf.decode('utf-8', errors='replace'))
            if not sent_trust and 'trust' in text.lower():
                sent_trust = True; time.sleep(0.2); os.write(master, b'\r')
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
    lines = [l.strip() for l in re.split(r'[\r\n]+', text) if l.strip()]
    flat = '\n'.join(lines).replace(' ', '')

    MONTHS = {'jan':1,'feb':2,'mar':3,'apr':4,'may':5,'jun':6,
              'jul':7,'aug':8,'sep':9,'oct':10,'nov':11,'dec':12}

    def to24h(t):
        m = re.match(r'(\d{1,2})(?::(\d{2}))?([ap]m)', t, re.I)
        if not m: return None
        h, mn, p = int(m.group(1)), int(m.group(2) or 0), m.group(3).lower()
        h = (0 if h == 12 else h) if p == 'am' else (h if h == 12 else h + 12)
        return f"{h:02d}:{mn:02d}"

    s_pct = w_pct = s_reset = w_reset = None

    m = re.search(r'[Cc]urr.{0,3}session.*?(\d+)%', flat, re.S)
    if m: s_pct = m.group(1)

    sa = re.search(r'[Cc]urr.{0,3}session(.*?)(?=[Cc]urrentweek|\Z)', flat, re.S)
    if sa:
        m = re.search(r'Rese.{0,2}(\d{1,2}(?::\d{2})?[ap]m)', sa.group(1), re.I)
        if m: s_reset = to24h(m.group(1))

    m = re.search(r'allmodels.*?(\d+)%', flat, re.S)
    if m: w_pct = m.group(1)

    m = re.search(r'Resets([A-Za-z]+)(\d+)at(\d{1,2}(?::\d{2})?[ap]m)', flat, re.I)
    if m:
        mon = MONTHS.get(m.group(1)[:3].lower(), m.group(1))
        w_reset = f"{mon}/{m.group(2)} {to24h(m.group(3))}"

    return s_pct, s_reset, w_pct, w_reset


def session_remain(hhmm):
    h, m = map(int, hhmm.split(':'))
    now = datetime.now()
    reset = now.replace(hour=h, minute=m, second=0, microsecond=0)
    if reset <= now: reset += timedelta(days=1)
    total_min = int((reset - now).total_seconds() // 60)
    return f"{total_min // 60}:{total_min % 60:02d}"


def weekly_remain(md_hhmm):
    # "4/30 19:00" 형태
    m = re.match(r'(\d+)/(\d+)\s+(\d+):(\d+)', md_hhmm)
    if not m: return None
    mon, day, h, mn = int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4))
    now = datetime.now()
    reset = now.replace(month=mon, day=day, hour=h, minute=mn, second=0, microsecond=0)
    if reset <= now: reset += timedelta(days=365)
    total_h = int((reset - now).total_seconds() // 3600)
    return f"{total_h}h"


def colorize(text, pct_str, is_session=True):
    try:
        pct = int(pct_str)
    except (ValueError, TypeError):
        return text
    if is_session and pct == 0:
        color = 'red'
    elif pct >= 85:
        color = 'red'
    elif pct >= 60:
        color = 'colour208'  # orange
    else:
        return text
    return f"#[fg={color}]{text}#[fg=default]"


def display(raw_line):
    parts = raw_line.strip().split('|')
    if len(parts) != 4: return '?'
    s_pct, s_reset, w_pct, w_reset = parts

    s_text = f"{s_pct}%"
    if s_reset:
        s_text += f" {session_remain(s_reset)}"

    w_text = f"{w_pct}%wk"
    w_rem = weekly_remain(w_reset) if w_reset else None
    if w_rem:
        w_text += f" {w_rem}"

    return f"{colorize(s_text, s_pct, is_session=True)} · {colorize(w_text, w_pct, is_session=False)}"


if __name__ == '__main__':
    mode = sys.argv[1] if len(sys.argv) > 1 else 'fetch'

    if mode == 'fetch':
        raw = fetch()
        if not raw:
            sys.exit(1)
        s_pct, s_reset, w_pct, w_reset = parse(raw)
        print(f"{s_pct or '?'}|{s_reset or ''}|{w_pct or '?'}|{w_reset or ''}")

    elif mode == 'display':
        line = sys.stdin.read()
        print(display(line))
