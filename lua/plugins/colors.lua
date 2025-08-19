
local ok, tokyonight = pcall(require, "tokyonight")
if ok then
  tokyonight.setup({
    style = "storm",
    terminal_colors = true,
    styles = { comments = { italic = true } },
  })
end

local flag = os.getenv("HOME") .. "/.config/nvim/.outdoor-mode"
if vim.fn.filereadable(flag) == 1 then
  vim.o.background = "light"
  vim.cmd("colorscheme tokyonight-day")
else
  vim.o.background = "dark"
  vim.opt.guifont = "FiraCode Nerd Font:h12"
  vim.g.fugitive_diff_vertical = 1
  vim.cmd("colorscheme tokyonight")   -- nu laddas "storm" tack vare setup() ovan
end
-- lua/plugins/colors.lua

