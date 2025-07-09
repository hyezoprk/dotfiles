---@diagnostic disable: undefined-global

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      'echasnovski/mini.icons',
      'nvim-lua/plenary.nvim'
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local fortune = require("alpha.fortune")
      local utils = require("user.utils")
      local header = utils.load_random_header()
      if header then
        dashboard.config.layout[2] = header
      else
        print("No images inside banner folder.")
      end

      -- dashboard.section.header.val = banners
      dashboard.section.buttons.val = {
        dashboard.button("e", "🏄   File Explorer", ":lua Snacks.explorer()<CR>"),
        dashboard.button("f", "🔎   Find file", utils.snacksCmd("files")),
        dashboard.button("r", "🍉   Recent file", utils.snacksCmd("recent")),
        dashboard.button("R", "🧠   Ripgrep", utils.snacksCmd("grep")),
        dashboard.button("c", "🤖   Configuration", ":e ~/.config/nvim/lua<CR>"),
        dashboard.button("b", "🎨   Change banner", utils.change_header),
        dashboard.button("q", "🚪   Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = fortune

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },
}
