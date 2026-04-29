local M = {}

function M.setup()
  require("user.autocmd.auto-import").setup()
  require("user.autocmd.auto-format").setup()
  require("user.autocmd.diagnostic-notify").setup()
  require("user.autocmd.ft").setup()
  require("user.autocmd.autosave").setup()
  require("user.autocmd.autoread").setup()
end

return M
