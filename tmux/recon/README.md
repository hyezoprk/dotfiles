# recon 설치 가이드

tmux 기반 Claude Code 에이전트 대시보드.
원본: https://github.com/gavraz/recon

## 설치

```bash
git clone https://github.com/gavraz/recon ~/dev/recon
cd ~/dev/recon
git apply ~/.config/tmux/recon/recon-fish-support.patch
cargo install --path .
```

## 패치 내용

`recon-fish-support.patch` — 두 가지 버그 수정 포함

### 1. fish 셸 세션 감지 버그

fish는 커맨드 실행 시 중간 자식 프로세스를 하나 더 생성해서
원본 recon이 Claude 세션을 감지하지 못하는 문제가 있음.

```
tmux pane (fish) → fish child → claude   ← 원본은 여기까지 못 봄
```

`find_claude_child_pid`를 재귀 탐색(최대 3단계)으로 변경해 해결.

### 2. `/clear` 이후 컨텍스트 사용량 정지 버그

`/clear` 실행 시 새 JSONL이 생성되지만 session JSON(`~/.claude/sessions/{PID}.json`)은
여전히 이전 session-id를 가리킴. recon이 stale JSONL을 계속 읽어 컨텍스트가 멈춤.

같은 프로젝트 디렉토리에서 매칭된 JSONL보다 최신이고 live session에 속하지 않는
JSONL이 있으면 그 파일로 전환하는 `find_post_clear_jsonl` 함수로 해결.

## tmux 단축키

| 단축키 | 동작 |
|--------|------|
| `prefix + g` | 대시보드 |
| `prefix + r` | resume picker |
| `prefix + N` | 새 세션 |
| `prefix + i` | 다음 Input 에이전트로 점프 |

## 주의

- Claude는 반드시 tmux 세션 안에서 실행해야 대시보드에 잡힘
- `recon launch` 또는 tmux 세션 안에서 `claude` 실행 모두 가능
