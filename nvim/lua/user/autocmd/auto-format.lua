local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
      vim.lsp.buf.format()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.fixAll.eslint" },
          diagnostics = {},
        },
        apply = true,
      })
    end,
  })
end

return M
