# recon 설치 가이드

tmux 기반 Claude Code 에이전트 대시보드.
원본: https://github.com/gavraz/recon

## 설치

```bash
git clone https://github.com/gavraz/recon /tmp/recon
cd /tmp/recon
git apply ~/.config/recon/recon-fish-support.patch
cargo install --path .
```

## 패치 내용

`recon-fish-support.patch` — fish 셸 세션 감지 버그 수정

fish는 커맨드 실행 시 중간 자식 프로세스를 하나 더 생성해서
원본 recon이 Claude 세션을 감지하지 못하는 문제가 있음.

```
tmux pane (fish) → fish child → claude   ← 원본은 여기까지 못 봄
```

`find_claude_child_pid`를 재귀 탐색(최대 3단계)으로 변경해 해결.

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
