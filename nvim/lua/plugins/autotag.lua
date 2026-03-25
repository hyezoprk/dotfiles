return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')

      npairs.setup({
        check_ts = true,
      })
      npairs.add_rules({
        Rule("*", "*", { "markdown", "mdx" }),
        Rule("~", "~", { "markdown", "mdx" }),
        Rule("_", "_", { "markdown", "mdx" }),
        Rule("<", ">", { "markdown", "mdx" }),
      })
    end
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      filetypes = { "html", "jsx", "tsx", "mdx" },
    },
  }
}
