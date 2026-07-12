#!/usr/bin/env bash
# 캐시: reset 시각·% 원본 데이터만 저장. 남은 시간은 매번 계산.
CACHE="/tmp/.claude_usage_raw"
LOCK="/tmp/.claude_usage_lock"
MAX_AGE=1200  # 20분 — %와 reset 시각만 갱신

PY="/Users/hyezoprk/.config/tmux/scripts/claude_usage.py"

LOCK_TTL=120  # 2분 넘은 lock은 stale로 간주

refresh_bg() {
    if [[ -f "$LOCK" ]]; then
        local lock_age=$(( $(date +%s) - $(stat -f %m "$LOCK" 2>/dev/null || echo 0) ))
        (( lock_age < LOCK_TTL )) && return
        rm -f "$LOCK"  # stale lock 제거
    fi
    touch "$LOCK"
    (
        if python3 "$PY" fetch > "${CACHE}.tmp" 2>/dev/null; then
            new_s_reset=$(cut -d'|' -f2 "${CACHE}.tmp")
            # 터미널 렌더링 corruption으로 세션 리셋 시각 파싱에 실패하면
            # 빈 값으로 기존 캐시를 덮어쓰지 않고 버림 (다음 폴링에서 재시도)
            if [[ -n "$new_s_reset" ]]; then
                mv "${CACHE}.tmp" "$CACHE"
            else
                rm -f "${CACHE}.tmp"
            fi
        fi
        rm -f "$LOCK"
    ) &
}

session_reset_passed() {
    local s_reset
    s_reset=$(cut -d'|' -f2 "$CACHE")
    [[ -z "$s_reset" ]] && return 1
    local reset_h reset_m now_mins reset_mins
    reset_h=${s_reset%:*}; reset_m=${s_reset#*:}
    now_mins=$(( 10#$(date +%H) * 60 + 10#$(date +%M) ))
    reset_mins=$(( 10#$reset_h * 60 + 10#$reset_m ))
    # reset이 지난 지 60분 이내인 경우 (자정 경계 고려)
    local diff=$(( (now_mins - reset_mins + 1440) % 1440 ))
    (( diff > 0 && diff < 60 ))
}

if [[ -f "$CACHE" ]]; then
    age=$(( $(date +%s) - $(stat -f %m "$CACHE" 2>/dev/null || echo 0) ))
    { [[ $age -gt $MAX_AGE ]] || session_reset_passed; } && refresh_bg
    python3 "$PY" display < "$CACHE" 2>/dev/null || echo "?"
else
    refresh_bg; wait
    [[ -f "$CACHE" ]] && python3 "$PY" display < "$CACHE" 2>/dev/null || echo "?"
fi
