# neovim config

## LuaSnip 스니펫 (MDX)

### Frontmatter

| 트리거 | 설명 |
|--------|------|
| `fm` | frontmatter 전체 (title / date 자동 / category choice / tag / description) |

### 컴포넌트

| 트리거 | 결과 | 비고 |
|--------|------|------|
| `img` | `<Img src="" alt="" />` | |
| `lnk` | `<Lnk href="" text="" />` | 외부 링크는 자동으로 `target="_blank"` |
| `yt` | `<Youtube src="" />` | YouTube 영상 |
| `ytpl` | `<YoutubePlaylist src="" />` | YouTube 플레이리스트 |
| `music` | `<Music src="" />` | YouTube 플레이리스트 플레이어 |
| `sc` | `<SoundCloud src="" />` | SoundCloud 임베드 |
| `book` | `<Book bid="" />` | 알라딘 ISBN13 |
| `movie` | `<Movie mid="" rating="4" />` | TMDB 영화 ID |
| `note` | `<Note type="">...</Note>` | type은 `<C-space>`로 순환 선택 |

### Admonition (blockquote)

| 트리거 | 결과 |
|--------|------|
| `ad` | `> [!TYPE]` — type을 `<C-space>`로 순환 선택 |
| `red` | `> [!red]` |
| `orange` | `> [!orange]` |
| `green` | `> [!green]` |
| `ask` | `> [!ask]` |
| `claude` | `> [!claude]` |

### 수영 Admonition

| 트리거 | 결과 |
|--------|------|
| `warm` | `> [!WARM]` |
| `main` | `> [!MAIN]` |
| `drill` | `> [!DRILL]` |
| `cool` | `> [!COOL]` |
