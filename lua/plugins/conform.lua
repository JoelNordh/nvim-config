return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = "", desc = "Format buffer" },
  },
  opts = {
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      python = { "ruff_format" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      markdown = { "prettier" },
      yaml = { "prettier" },
      sh = { "shfmt" },
      lua = { "stylua" },
    },
    format_on_save = { timeout_ms = 1000, lsp_fallback = true },
  },
}
