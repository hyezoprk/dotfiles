local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("ts_fix_imports", { clear = true }),
    desc = "Auto-fix TypeScript imports on save",
    pattern = { "*.ts", "*.tsx" },
    callback = function()
      local params = vim.lsp.util.make_range_params()
      params.context = {
        only = { "source.addMissingImports.ts", "source.removeUnused.ts" },
      }
      local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
      if not results then return end

      local actions = {}
      for _, res in pairs(results) do
        for _, action in pairs(res.result or {}) do
          if action.edit or action.command then
            table.insert(actions, action)
          end
        end
      end

      if #actions == 0 then return end

      for _, action in ipairs(actions) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
        end
        if action.command then
          vim.lsp.buf.execute_command(action.command)
        end
      end

      -- 저장은 한 번만!
      vim.cmd("silent! write")
    end,
  })
end

return M
