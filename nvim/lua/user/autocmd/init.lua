local M = {}

function M.setup()
	require("user.autocmd.auto-import").setup()
	require("user.autocmd.auto-format").setup()
	-- require("user.autocmd.autosave").setup()
end

return M
