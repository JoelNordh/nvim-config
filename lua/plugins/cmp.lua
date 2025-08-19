
local ok, cmp = pcall(require, 'cmp')
if not ok then return end
local luasnip = require('luasnip')

pcall(require, 'cmp-npm').setup({})

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { 'i','s' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { 'i','s' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' }, { name = 'luasnip' },
    { name = 'buffer' },   { name = 'path' }, { name = 'npm' },
  },
})

local ok_ap, cmp_ap = pcall(require, 'nvim-autopairs.completion.cmp')
if ok_ap then
  cmp.event:on('confirm_done', cmp_ap.on_confirm_done())
end
