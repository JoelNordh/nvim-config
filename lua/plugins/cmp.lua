
vim.schedule(function() vim.notify("cmp.lua loaded") end)
local ok, cmp = pcall(require, 'cmp')
if not ok then return end
local luasnip = require('luasnip')

local ok_npm, cmp_npm = pcall(require, 'cmp-npm')
if ok_npm then
  cmp_npm.setup({})
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fb)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fb() end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fb)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fb() end
    end, { 'i', 's' }),

    -- Två lika triggers:
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-@>']     = cmp.mapping.complete(),
    ['<C-l>']       = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' }, { name = 'luasnip' },
    { name = 'buffer' },   { name = 'path'  }, { name = 'npm' },
  },
})
-- extra “hard” mapping om något annat stjäl tangenten:
vim.keymap.set('i','<C-Space>', function() require('cmp').complete() end, { desc='CMP complete' })
vim.keymap.set('i','<C-@>',     function() require('cmp').complete() end, { desc='CMP complete (C-@)' })

vim.keymap.set('i','<C-l>',     function() require('cmp').complete() end, { desc='CMP complete (C-l)' })


vim.schedule(function() vim.notify("cmp.lua finished loaded") end)

