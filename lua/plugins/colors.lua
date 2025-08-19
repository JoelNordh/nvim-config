
-- lua/plugins/colors.lua

-- Outdoor/indoor mode switch + tokyonight
local flag = vim.fn.expand("~/.config/nvim/.outdoor-mode")

-- RÄTT sätt att pcall:a require
local ok_tk, tokyonight = pcall(require, "tokyonight")
if ok_tk then
  tokyonight.setup({
    style = "storm",
    terminal_colors = true,
    styles = { comments = { italic = true } },
  })
end

if vim.fn.filereadable(flag) == 1 then
  vim.o.background = "light"
  vim.cmd("colorscheme tokyonight-day")
else
  vim.o.background = "dark"
  vim.opt.guifont = "FiraCode Nerd Font:h12")
  vim.g.fugitive_diff_vertical = 1
  vim.cmd("colorscheme tokyonight")
end

-- indent-blankline
local ok_ibl, ibl = pcall(require, "ibl")
if ok_ibl then ibl.setup() end
