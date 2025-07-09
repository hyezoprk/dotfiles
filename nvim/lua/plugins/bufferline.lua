return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        indicator_icon = ' ',
        separator_style = { '', '' },
        buffer_close_icon = '',
        tab_size = 1,
        close_icon = '',
        -- modified_icon = '',
      }
    })
  end
}
