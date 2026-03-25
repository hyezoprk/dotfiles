local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function(args)
      local bufnr = args.buf
      -- LSP가 attach되어 있는지 확인
      local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
      if #clients == 0 then return end

      -- diagnostics 가져오기
      local diagnostics = vim.diagnostic.get(bufnr)
      if #diagnostics == 0 then return end

      -- 에러만 출력
      for _, d in ipairs(diagnostics) do
        if d.severity == vim.diagnostic.severity.ERROR then
          local msg = string.format("[%s] %s", d.source or "LSP", d.message)
          vim.notify(msg, vim.log.levels.ERROR)
        end
      end

      -- 전부다 출력
      -- for _, d in ipairs(diagnostics) do
      --   local level = ({
      --     [vim.diagnostic.severity.ERROR] = vim.log.levels.ERROR,
      --     [vim.diagnostic.severity.WARN]  = vim.log.levels.WARN,
      --     [vim.diagnostic.severity.INFO]  = vim.log.levels.INFO,
      --     [vim.diagnostic.severity.HINT]  = vim.log.levels.INFO,
      --   })[d.severity] or vim.log.levels.INFO
      --
      --   local msg = string.format("[%s] %s (line %d)", d.source or "LSP", d.message, d.lnum + 1)
      --   vim.notify(msg, level)
      -- end
    end,
  })
end

return M
