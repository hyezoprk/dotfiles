return {
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_transparent_background = 1
      vim.g.sonokai_style = "andromeda"
      vim.cmd.colorscheme('sonokai')
      vim.cmd('highlight StatusLine guibg=NONE ctermbg=NONE')
      vim.cmd('highlight StatusLineNC guibg=NONE ctermbg=NONE')
      vim.cmd('highlight TabLineFill guibg=NONE ctermbg=NONE')
      vim.cmd('highlight NormalFloat guibg=NONE ctermbg=NONE')
      vim.cmd('highlight FloatBorder guibg=NONE ctermbg=NONE')
      vim.cmd('highlight FloatTitle guibg=NONE ctermbg=NONE')
      -- Atlantis 테마
      -- 파란색
      vim.cmd('highlight typescriptMember guifg=#6DCAE8')
      vim.cmd('highlight typescriptClassKeyword guifg=#6DCAE8')
      vim.cmd('highlight typescriptVariable guifg=#6DCAE8')
      vim.cmd('highlight @lsp.typemod.class.declaration.typescript guifg=#6DCAE8')
      -- 주황색
      vim.cmd('highlight @lsp.mod.declaration.typescript guifg=#F89860')
      -- 흰색
      vim.cmd('highlight @lsp.type.property.typescript guifg=#E1E3E4')
      vim.cmd('highlight typescriptIdentifierName guifg=#E1E3E4')
      -- 초록색
      vim.cmd('highlight @lsp.typemod.member.declaration.typescript guifg=#9ED06C')
      vim.cmd('highlight @lsp.type.member.typescript guifg=#9ED06C')
      -- 보라색
      vim.cmd('highlight @lsp.typemod.variable.declaration.typescript guifg=#BB97EE')
      -- 회색
      vim.cmd('highlight typescriptDecorator guifg=#7E8294')
    end
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      vim.cmd('highlight RainbowDelimiterBlue guifg=#6DCAE8')
      vim.cmd('highlight RainbowDelimiterOrange guifg=#F89860')
      vim.cmd('highlight RainbowDelimiterGreen guifg=#9ED06C')
      vim.cmd('highlight RainbowDelimiterCyan guifg=#7E8294')
      vim.cmd('highlight RainbowDelimiterYellow guifg=#EDC763')
      vim.cmd('highlight RainbowDelimiterViolet guifg=#BB97EE')
      vim.g.rainbow_delimiters = {
        highlight = {
          'RainbowDelimiterYellow',
          'RainbowDelimiterViolet',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterCyan',
        },
      }
    end,
  }
}
