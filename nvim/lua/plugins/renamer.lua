return {
  "filipdutescu/renamer.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("renamer").setup()
    vim.keymap.set("n", "gr", function() require("renamer").rename({}) end, { desc = "Rename symbol" })
  end,
}
