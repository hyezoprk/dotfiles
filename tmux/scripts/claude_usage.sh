#!/usr/bin/env bash
# 캐시: reset 시각·% 원본 데이터만 저장. 남은 시간은 매번 계산.
CACHE="/tmp/.claude_usage_raw"
LOCK="/tmp/.claude_usage_lock"
MAX_AGE=1200  # 20분 — %와 reset 시각만 갱신

PY="/Users/hyezoprk/.config/tmux/scripts/claude_usage.py"

refresh_bg() {
    [[ -f "$LOCK" ]] && return
    touch "$LOCK"
    (python3 "$PY" fetch > "${CACHE}.tmp" 2>/dev/null \
        && mv "${CACHE}.tmp" "$CACHE"; rm -f "$LOCK") &
}

if [[ -f "$CACHE" ]]; then
    age=$(( $(date +%s) - $(stat -f %m "$CACHE" 2>/dev/null || echo 0) ))
    [[ $age -gt $MAX_AGE ]] && refresh_bg
    python3 "$PY" display < "$CACHE" 2>/dev/null || echo "?"
else
    refresh_bg; wait
    [[ -f "$CACHE" ]] && python3 "$PY" display < "$CACHE" 2>/dev/null || echo "?"
fi
