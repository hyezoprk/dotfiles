return {
  "OXY2DEV/markview.nvim",
  dependencies = { "echasnovski/mini.icons", "saghen/blink.cmp" },
  lazy = false,
  config = function()
    local presets_checkboxes = require("markview.presets").checkboxes
    local presets_headings = require("markview.presets").headings
    local presets_horizontal = require("markview.presets").horizontal_rules

    require("markview").setup({
      experimental = {
        check_rtp_message = false,
      },

      preview = {
        enable = true,
        render_distance = { 200, 200 },
        filetypes = { "markdown", "mdx" },
      },
      markdown = {
        headings = presets_headings.glow, --other cool opts are  or presets.glow_center
        horizontal_rules = presets_horizontal.thick,
        list_items = {
          indent_size = 1,
          shift_width = 1,
        },
        -- 수영 admonition 자동완성 등록 (blink-markview가 이 목록을 읽음)
        block_quotes = {
          WARM  = { preview = "Warm-up",   border = "│" },
          MAIN  = { preview = "Main set",  border = "│" },
          DRILL = { preview = "Drill",     border = "│" },
          COOL  = { preview = "Cool-down", border = "│" },
        },
      },
      markdown_inline = {
        checkboxes = presets_checkboxes.nerd,
      },
      latex = {
        enable = true,
        inlines = { enable = true },
        commands = {
          ["sin"] = {},
        },
      },
    })

    require("markview.extras.checkboxes").setup({
      ---@type string
      default = "X",
      ---@type
      ---| "disable"
      ---| "checkbox"
      ---| "list_item"
      remove_style = "disable",
      ---@type string[][]
      states = {
        { " ", "/", "X" },
        { "<", ">" },
        { "?", "!", "*" },
        { '"' },
        { "l", "b", "i" },
        { "S", "I" },
        { "p", "c" },
        { "f", "k", "w" },
        { "u", "d" },
      },
    })
  end,
}
