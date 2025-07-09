---@diagnostic disable: undefined-doc-name

return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "1.*",
  build = "cargo build --release",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "enter" },
    completion = {
      -- documentation = { auto_show = true, auto_show_delay_ms = 500 },
      ghost_text = { enabled = true }
    },
    -- sources = {
    --   default = { "lsp", "path", "snippets", "buffer" },
    -- },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" },
}
