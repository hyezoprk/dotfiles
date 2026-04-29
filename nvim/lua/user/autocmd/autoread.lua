local M = {}

function M.setup()
  vim.o.autoread = true
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    command = "checktime",
    desc = "외부에서 파일 변경 시 자동 리로드",
  })
end

return M
