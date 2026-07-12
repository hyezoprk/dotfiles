return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    -- autopair는 nvim-autopairs(autotag.lua)로 통일. mini.pairs는 사용하지 않음.
    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.jump2d").setup({
      spotter = require("mini.jump2d").builtin_opts.word_start.spotter,
      view = {
        n_steps_ahead = 2
      },
      mappings = {
        start_jumping = 'f'
      },
      labels = 'qwetadfgzxcvbnmlkjhpoiuy',
      silent = true
    })

    vim.api.nvim_set_hl(0, 'MiniJump2dSpot', { fg = '#85c1e9', bold = true, italic = true })
    vim.api.nvim_set_hl(0, 'MiniJump2dSpotAhead', { fg = '#cccccc', italic = true })
  end,
}
