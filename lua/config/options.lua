
local o = vim.opt
o.number = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.smartindent = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.termguicolors = true
o.ignorecase = true
o.smartcase = true
o.autoread = true

-- vimtex
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_quickfix_mode = 0

-- Indent guides
-- (plugin configured separately; base option here if any)
