pcall(function() vim.loader.enable() end)

-- Set leader early
vim.g.mapleader = " "

-- Core config (kept plugin-agnostic; must not require() any plugin module)
require("config.options")

-- Plugins (lazy.nvim). Bootstraps lazy.nvim and imports every spec in
-- lua/plugins/*.lua. Plugins are lazy-loaded per their own triggers
-- (event/cmd/ft/keys) instead of being eagerly required here.
require("config.lazy")

require("config.keymaps")
require("config.autocmds")
require("config.utils")      -- helper functions + user commands

-- My own plugins
require("service_explorer")

vim.api.nvim_create_user_command('ReloadConfig', function()
  for name, _ in pairs(package.loaded) do
    if name:match('^config') or name:match('^service_explorer') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath('config') .. '/init.lua')
  print('Config reloaded (use :Lazy reload <plugin> for plugin spec changes)')
end, {})

vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
