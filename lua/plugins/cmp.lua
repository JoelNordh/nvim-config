return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "David-Kunz/cmp-npm",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local ok_npm, cmp_npm = pcall(require, "cmp-npm")
    if ok_npm then cmp_npm.setup({}) end

    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.setup({
      snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
      mapping = {
        ["<Tab>"] = cmp.mapping(function(fb)
          if cmp.visible() then cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
          else fb() end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fb)
          if cmp.visible() then cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then luasnip.jump(-1)
          else fb() end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-l>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
        { name = "npm" },
      }),
    })

    -- `/` and `?` search completion from the current buffer
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })

    -- `:` command-line completion (paths + commands)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
    })
  end,
}
