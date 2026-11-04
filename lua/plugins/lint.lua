-- Covers linting conform.nvim doesn't (python/ruff already gets diagnostics
-- from the ruff LSP server in lsp.lua, so it's intentionally not duplicated
-- here).
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      sh = { "shellcheck" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      -- Prose/style linting for PM docs (grammar/style only; spelling is
      -- handled separately by Neovim's built-in `spell` option).
      markdown = { "vale" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function() lint.try_lint() end,
    })
  end,
}
