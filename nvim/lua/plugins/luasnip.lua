return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local i = ls.insert_node
      local c = ls.choice_node
      local t = ls.text_node
      local f = ls.function_node
      local fmt = require("luasnip.extras.fmt").fmt

      -- choice node 순환 키
      vim.keymap.set({ "i", "s" }, "<C-space>", function()
        if ls.choice_active() then ls.change_choice(1) end
      end, { silent = true })

      ls.add_snippets("mdx", {
        -- MDX frontmatter
        s("fm", fmt(
          '---\ntitle: "{}"\ndate: "{}"\ncategory: "{}"\ntag: "{}"\ndescription: "{}"\ntype: "{}"\n---\n\n{}',
          {
            i(1, "제목"),
            f(function() return os.date("%Y-%m-%d") end),
            c(2, {
              t("chips"),
              t("essays"),
              t("swimming"),
            }),
            i(3, "태그"),
            i(4),
            c(5, {
              t(""),
              t("center"),
              t("fiction"),
            }),
            i(0),
          }
        )),

        -- <Note type="highlight">...</Note>
        -- type을 <C-l>/<C-h>로 순환 선택
        s("note", fmt('<Note type="{}">{}</Note>', {
          c(1, {
            t("highlight"),
            t("underline"),
            t("box"),
            t("circle"),
            t("strike-through"),
            t("crossed-off"),
            t("bracket"),
          }),
          i(2),
        })),

        -- <Img src="..." alt="..." />
        s("img", fmt('<Img src="{}" alt="{}" />', { i(1), i(2) })),

        -- <Lnk href="..." text="..." />
        s("lnk", fmt('<Lnk href="{}" text="{}" />', { i(1), i(2) })),

        -- <Youtube src="..." />
        s("yt", fmt('<Youtube src="{}" />', { i(1) })),

        -- <YoutubePlaylist src="..." />
        s("ytpl", fmt('<YoutubePlaylist src="{}" />', { i(1) })),

        -- <Music src="..." />
        s("music", fmt('<Music src="{}" />', { i(1) })),

        -- <SoundCloud src="..." />
        s("sc", fmt('<SoundCloud src="{}" />', { i(1) })),

        -- <Center>...</Center>
        s("center", fmt('<Center>\n{}\n</Center>', { i(1) })),

        -- <Book bid="..." />
        s("book", fmt('<Book bid="{}" />', { i(1) })),

        -- <Movie mid="..." rating="..." at="..." with="..." />
        s("movie", fmt('<Movie mid="{}" rating="{}" />', { i(1), i(2, "4") })),

        -- blockquote label (color badges)
        s("red",    { t({ "> [!red]",    "> " }), i(0) }),
        s("orange", { t({ "> [!orange]", "> " }), i(0) }),
        s("green",  { t({ "> [!green]",  "> " }), i(0) }),
        s("ask",    { t({ "> [!ask]",    "> " }), i(0) }),
        s("claude", { t({ "> [!claude]", "> " }), i(0) }),
        s("fold",   fmt('> [!fold] {}\n> {}', { i(1, "제목"), i(0) })),

        -- ── 수영 admonition ──────────────────────────────────────────
        s("warm",  fmt('> [!WARM]{}\n> {}', { i(1), i(0) })),
        s("main",  fmt('> [!MAIN]{}\n> {}', { i(1), i(0) })),
        s("drill", fmt('> [!DRILL]{}\n> {}', { i(1), i(0) })),
        s("cool",  fmt('> [!COOL]{}\n> {}', { i(1), i(0) })),

        -- ── GitHub 스타일 admonition (choice node로 한 번에) ──────────
        s("ad", fmt('> [!{}]\n> {}', {
          c(1, {
            t("NOTE"),
            t("TIP"),
            t("IMPORTANT"),
            t("WARNING"),
            t("CAUTION"),
            t("ABSTRACT"),
            t("INFO"),
            t("SUCCESS"),
            t("DANGER"),
            t("QUESTION"),
            t("QUOTE"),
            t("FAILURE"),
            t("BUG"),
            t("EXAMPLE"),
            t("TODO"),
          }),
          i(2),
        })),
      })
    end,
  },
}
