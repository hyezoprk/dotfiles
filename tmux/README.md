# tmux 설정

## 구조

```
tmux/
├── tmux.conf              # 메인 설정
├── plugins/               # TPM 플러그인
├── scripts/
│   ├── blink_clock.sh     # (미사용) 이전 시계 스크립트
│   ├── claude_usage.py    # claude /usage PTY fetch + display 계산
│   └── claude_usage.sh    # 상태바 캐시 래퍼 (20분 캐싱)
└── recon/
    ├── README.md          # recon 설치 가이드
    └── recon-fish-support.patch
```

## 단축키

| 단축키 | 동작 |
|--------|------|
| `prefix + R` | tmux.conf 리로드 |
| `prefix + g` | recon 대시보드 팝업 |
| `prefix + r` | recon resume picker |
| `prefix + N` | recon 새 Claude 세션 |
| `prefix + i` | 다음 Input 대기 에이전트로 점프 |
| `prefix + h/j/k/l` | pane 이동 (vim 방향키) |
| `prefix + v` | copy mode |
| `prefix + q` | tmux 서버 종료 |

## 상태바

우측: `세션사용% 남은시간 · 주간사용%wk 주간남은시간h / 현재경로 / 세션명`

색상 기준:
- 세션 0% 또는 85%+: 빨강
- 세션 60~84%: 주황
- 주간 85%+: 빨강
- 주간 60~84%: 주황

캐시: `/tmp/.claude_usage_raw` (20분마다 갱신, `rm /tmp/.claude_usage_raw`로 강제 갱신)

## recon 설치

신규 설치 또는 재설치 시 → [`recon/README.md`](recon/README.md) 참고
