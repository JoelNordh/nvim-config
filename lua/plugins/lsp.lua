
local ok_lsp, lspconfig = pcall(require, 'lspconfig')
if not ok_lsp then return end
pcall(require, 'mason')            -- optional, you can add mason.setup() if you use it
pcall(require, 'mason-lspconfig')  -- optional

vim.lsp.set_log_level("WARN")

local capabilities = require('cmp_nvim_lsp')
  .default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- TypeScript/JS
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  filetypes = { "typescript","typescriptreact","typescript.tsx","javascript","javascriptreact","javascript.jsx" },
})

-- Python
lspconfig.pyright.setup({ capabilities = capabilities })

-- CSS/SCSS
lspconfig.cssls.setup({ capabilities = capabilities, filetypes = { "css","scss" } })

-- JSON
lspconfig.jsonls.setup({ capabilities = capabilities })

-- C/C++
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = { "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--query-driver=/usr/bin/arm-none-eabi-*" 
  },
  filetypes = { "c","cpp","objc","objcpp" },
  root_dir = lspconfig.util.find_git_ancestor,
  init_options = { compilationDatabasePath = vim.fn.getcwd() .. "/x86" },
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n','gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n','gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n','gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n','gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n','K',  vim.lsp.buf.hover, opts)
    vim.keymap.set('n','<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n','gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n','lf', vim.lsp.buf.format, opts)
    vim.keymap.set('n','ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v','ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<leader>jb', '<cmd>Telescope jumplist<CR>', { desc = "Show jump list" })
  end,
})
