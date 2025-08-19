
local ok, luasnip = pcall(require, 'luasnip')
if not ok then return end

luasnip.setup({})
pcall(require("luasnip.loaders.from_vscode").lazy_load, { paths = "~/.config/nvim/snippets" })
pcall(require("luasnip.loaders.from_lua").load, { paths = "~/.config/nvim/lua/snippets" })
