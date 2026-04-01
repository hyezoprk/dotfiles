# dotfiles

macOS 개발 환경 설정 모음. Neovim + tmux + Ghostty + Fish shell.

## 구성

| 도구 | 설명 |
|------|------|
| Neovim | lazy.nvim 기반, LSP/Copilot/Snacks 등 |
| tmux | TPM 기반, catppuccin 테마 |
| Fish | starship 프롬프트 |
| Ghostty | 터미널 에뮬레이터 |
| yabai + skhd | 타일링 윈도우 매니저 |

---

## Neovim

> `<leader>` = `Space`

### 일반 이동

| 키 | 동작 |
|----|------|
| `j` / `k` | 시각적 줄 기준 이동 (줄바꿈 포함) |
| `$` | 줄 **시작**으로 이동 (`^`와 스왑됨) |
| `^` | 줄 **끝**으로 이동 (`$`와 스왑됨) |
| `Ctrl+f` | 반 페이지 아래 스크롤 |
| `Ctrl+g` | 반 페이지 위 스크롤 |
| `Ctrl+h` | 왼쪽 창으로 이동 |
| `Tab` | 다음 참조로 이동 (Snacks.words) |
| `Shift+Tab` | 이전 참조로 이동 |

### 편집

| 키 | 동작 |
|----|------|
| `x` / `dd` | 클립보드 없이 삭제 |
| `v p` | 붙여넣기 후 원본 텍스트 유지 |
| `\` | 마지막 f/t 동작 반복 (`;` 대체) |
| `Alt+Backspace` | 단어 단위 삭제 (insert/terminal) |
| `Shift+Enter` | 코드 포맷 |
| `Ctrl+Enter` | Code Action |
| `Alt+Enter` | 저장 |
| `Escape` | 검색 하이라이트 제거 |

### g 키 (LSP)

| 키 | 동작 |
|----|------|
| `gd` | 정의로 이동 (Go to Definition) |
| `gD` | 선언으로 이동 (Go to Declaration) |
| `gh` | 참조 목록 (References) |
| `gi` | 구현으로 이동 (Go to Implementation) |
| `gt` | 타입 정의로 이동 |
| `gr` | 심볼 이름 변경 (Rename) |
| `K` | LSP hover 문서 |

### 점프 (mini.jump2d)

| 키 | 동작 |
|----|------|
| `f` | 화면 내 단어 시작 위치로 점프 |

### 마크

| 키 | 동작 |
|----|------|
| `Backspace` | 마크 이동 트리거 (`'` 대체) |
| `Ctrl+m` | 모든 마크 삭제 |

### 버퍼

| 키 | 동작 |
|----|------|
| `Ctrl+e` | 다음 버퍼 |
| `Ctrl+q` | 이전 버퍼 |
| `<leader>w` | 현재 버퍼 닫기 |
| `<leader>W` | 현재 버퍼 제외 전부 닫기 |

### 터미널

| 키 | 동작 |
|----|------|
| `Ctrl+t` | 플로팅 터미널 토글 |
| `Ctrl+q` (terminal) | 터미널 모드 탈출 |

### Leader 단축키

| 키 | 동작 |
|----|------|
| `<leader><space>` | Smart Find Files |
| `<leader>e` | 파일 탐색기 |
| `<leader>D` | Dashboard |
| `<leader>L` | Lazy 플러그인 매니저 |
| `<leader>c` | Neovim 설정 열기 |
| `<leader>q` | 저장 후 종료 |
| `<leader>z` | Zen 모드 |
| `<leader>.` | Scratch 버퍼 |
| `<leader>gg` | LazyGit |

### Find `<leader>f`

| 키 | 동작 |
|----|------|
| `<leader>ff` | 파일 찾기 |
| `<leader>fb` | 버퍼 목록 |
| `<leader>fg` | Grep |
| `<leader>fp` | 프로젝트 목록 |
| `<leader>fr` | 최근 파일 |
| `<leader>fm` | 마크 목록 |
| `<leader>f"` | 레지스터 목록 |
| `<leader>fd` | 진단(Diagnostics) |
| `<leader>fD` | 현재 버퍼 진단 |
| `<leader>fs` | LSP 심볼 |
| `<leader>fS` | LSP 워크스페이스 심볼 |

### Git `<leader>g`

| 키 | 동작 |
|----|------|
| `<leader>gg` | LazyGit |
| `<leader>gb` | 브랜치 목록 |
| `<leader>gl` | Git Log |
| `<leader>gL` | 현재 줄 Git Log |
| `<leader>gs` | Git Status |
| `<leader>gS` | Git Stash |
| `<leader>gd` | Git Diff |
| `<leader>gf` | 현재 파일 Git Log |

### Search `<leader>s`

| 키 | 동작 |
|----|------|
| `<leader>sg` | Grep |
| `<leader>sw` | 선택 영역/단어 Grep |
| `<leader>sb` | 버퍼 내 검색 |
| `<leader>sB` | 열린 버퍼 전체 Grep |
| `<leader>sh` | Help 페이지 |
| `<leader>sk` | 키맵 목록 |
| `<leader>sc` | 명령어 히스토리 |
| `<leader>sC` | 명령어 목록 |
| `<leader>sj` | Jump 목록 |
| `<leader>su` | Undo 히스토리 |
| `<leader>sR` | 마지막 검색 재개 |
| `<leader>sp` | 플러그인 검색 |
| `<leader>sf` | 버퍼 디렉토리 기준 정렬 |

### Todo `<leader>t`

| 키 | 동작 |
|----|------|
| `<leader>tf` | TODO 찾기 |
| `<leader>tF` | TODO/FIX/FIXME 찾기 |
| `<leader>td` | Dooing 할 일 목록 |

### Debug `<leader>d`

| 키 | 동작 |
|----|------|
| `<leader>dd` | 빌드 & 디버그 |
| `<leader>dr` | 빌드 없이 디버그 |
| `<leader>dt` | 테스트 디버그 |
| `<leader>b` | 브레이크포인트 토글 |
| `<leader>dx` | 디버거 종료 |

### Xcode `<leader>x`

| 키 | 동작 |
|----|------|
| `<leader>xb` | 빌드 |
| `<leader>xr` | 빌드 & 실행 |
| `<leader>xt` | 테스트 실행 |
| `<leader>xd` | 디바이스 선택 |
| `<leader>xl` | 빌드 로그 토글 |
| `<leader>xp` | 빌드 Picker |

### 서라운드 (mini.surround)

| 키 | 동작 |
|----|------|
| `sa` | 서라운드 추가 (예: `saiw"`) |
| `sd` | 서라운드 삭제 |
| `sr` | 서라운드 교체 |

### 주석 (mini.comment)

| 키 | 동작 |
|----|------|
| `gcc` | 현재 줄 주석 토글 |
| `gc` + motion | 범위 주석 토글 |

---

## tmux

> prefix = `Ctrl+b`

### 세션

| 키 | 동작 |
|----|------|
| `prefix + Ctrl+s` | 세션 저장 (resurrect) |
| `prefix + Ctrl+r` | 세션 복원 (resurrect) |
| `prefix + q` | tmux 서버 종료 |
| `prefix + r` | tmux.conf 리로드 |

### 창/패널

| 키 | 동작 |
|----|------|
| `prefix + c` | 새 윈도우 |
| `prefix + ,` | 윈도우 이름 변경 |
| `prefix + n` / `p` | 다음/이전 윈도우 |
| `prefix + %` | 수직 분할 |
| `prefix + "` | 수평 분할 |
| `prefix + h/j/k/l` | 패널 이동 (vim 방향키) |
| `prefix + z` | 패널 전체화면 토글 |
| `prefix + x` | 패널 닫기 |

### 복사

| 키 | 동작 |
|----|------|
| `prefix + v` | 복사 모드 진입 |
| `v` (복사모드) | 선택 시작 |
| `y` (복사모드) | 복사 후 종료 |

---

## Fish

| 명령어 | 동작 |
|--------|------|
| `Ctrl+r` | 히스토리 검색 |
| `Alt+→` | 단어 단위 이동 |
| `Tab` | 자동완성 |
