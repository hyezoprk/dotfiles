local M = {}

function M.setup()
  vim.filetype.add({
    extension = {
      mdx = "mdx",
    },
  })

  vim.treesitter.language.register("markdown", "mdx")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "mdx",
    callback = function()
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
      vim.bo.expandtab = true
    end,
  })
end

return M
