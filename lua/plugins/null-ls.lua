
local ok, null_ls = pcall(require, "none-ls")
if not ok then return end

local formatting = null_ls.builtins.formatting

-- One autocmd group for format-on-save
local augroup = vim.api.nvim_create_augroup("LspFormat", { clear = true })

null_ls.setup({
  sources = {
    formatting.clang_format,
    formatting.prettier,
    -- diagnostics can be added here e.g. null_ls.builtins.diagnostics.eslint_d
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
      })
    end
  end,
})
