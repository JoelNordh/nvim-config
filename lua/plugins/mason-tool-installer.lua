-- Auto-installs the non-LSP CLI tools that conform.nvim (formatters) and
-- nvim-lint (linters) shell out to, via Mason, so a fresh clone of this
-- config doesn't require manual `apt`/`pip`/`npm` installs for these.
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  event = "VeryLazy",
  opts = {
    ensure_installed = {
      "stylua", "shfmt", "shellcheck", "eslint_d", "prettier", "clang-format",
      "vale",
    },
  },
}
