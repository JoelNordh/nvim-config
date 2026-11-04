
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

-- Spellcheck is on everywhere by default (accessibility requirement, not
-- just a markdown/org nicety) -- see the FileType autocmd in autocmds.lua
-- that turns it back off for UI/utility buffers where it'd just be noise.
o.spell = true
o.spelllang = { "en_us" }
