return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters = {
      prettierd = {
        prepend_args = { "--tab-width", "2", "--no-semi", "--object-wrap", "preserve" },
      }
    },
    formatters_by_ft = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
