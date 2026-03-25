---@diagnostic disable: undefined-doc-name

return {
  "saghen/blink.cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "giuxtaposition/blink-cmp-copilot",
    "zbirenbaum/copilot.lua",
  },
  version = "1.*",
  build = "cargo build --release",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- preset = "enter",
      ["<CR>"] = { "fallback" }, -- 줄바꿈만
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Tab>"] = { "accept", "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    completion = {
      -- list = {
      --   selection = {
      --     preselect = false,
      --   }
      -- },
      -- documentation = { auto_show = true, auto_show_delay_ms = 500 },
      -- ghost_text = { enabled = true }
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
      -- MDX 파일에선 buffer 소스 끄기 (파일 내 텍스트가 LSP와 섞이는 문제)
      per_filetype = {
        mdx = { "lsp", "path", "snippets", "copilot" },
      },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        }
      }
    },
    snippets = {
      preset = 'luasnip'
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" },
}
