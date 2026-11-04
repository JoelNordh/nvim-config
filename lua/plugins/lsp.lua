return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- clangd/pyright/ts_ls/cssls/jsonls: existing C++/web stack.
      -- ruff/bashls/yamlls: added for the Python- and scripting-heavier
      -- product-management workload (linting/formatting-focused tooling,
      -- shell scripts, and YAML config files).
      ensure_installed = {
        "clangd", "pyright", "ruff", "ts_ls", "cssls", "jsonls", "bashls", "yamlls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      vim.lsp.set_log_level("WARN")

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Shared keymaps applied to every server below via on_attach.
      local function on_attach(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "lf", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("v", "ca", vim.lsp.buf.code_action, opts)
      end

      -- TypeScript/JS
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
      })

      -- Python: pyright for types/intellisense, ruff for fast linting + import actions
      lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.ruff.setup({ capabilities = capabilities, on_attach = on_attach })

      -- CSS/SCSS
      lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach, filetypes = { "css", "scss" } })

      -- JSON / YAML (config files, common for scripting & product work)
      lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.yamlls.setup({ capabilities = capabilities, on_attach = on_attach })

      -- Shell scripts
      lspconfig.bashls.setup({ capabilities = capabilities, on_attach = on_attach })

      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--query-driver=/usr/bin/arm-none-eabi-*",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },

        -- Prefer the nearest compilation database / .clangd, otherwise fall back to git root
        root_dir = function(fname)
          return util.root_pattern("compile_commands.json", "compile_flags.txt", ".clangd")(fname)
            or util.find_git_ancestor(fname)
        end,

        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.keymap.set("n", "<leader>jb", "<cmd>Telescope jumplist<CR>", { desc = "Show jump list" })
        end,
      })
    end,
  },
}
