#!/usr/bin/env bash
CACHE="/tmp/.claude_usage_cache"
LOCK="/tmp/.claude_usage_lock"
MAX_AGE=1200  # 20 minutes

refresh_bg() {
    [[ -f "$LOCK" ]] && return
    touch "$LOCK"
    (
        python3 /Users/hyezoprk/.config/tmux/scripts/claude_usage.py > "$CACHE.tmp" 2>/dev/null \
            && mv "$CACHE.tmp" "$CACHE"
        rm -f "$LOCK"
    ) &
}

if [[ -f "$CACHE" ]]; then
    cat "$CACHE"
    age=$(( $(date +%s) - $(stat -f %m "$CACHE" 2>/dev/null || echo 0) ))
    [[ $age -gt $MAX_AGE ]] && refresh_bg
    exit 0
fi

# 최초 실행: 동기 fetch
refresh_bg
wait
cat "$CACHE" 2>/dev/null || echo "?"
