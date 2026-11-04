-- Bootstraps lazy.nvim (cloning it on first run) and loads every plugin spec
-- under lua/plugins/. Each file in that directory returns one lazy.nvim spec
-- (or a list of specs) combining the plugin declaration, its lazy-load
-- triggers, and its config in one place.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false },
  change_detection = { notify = false },
})
