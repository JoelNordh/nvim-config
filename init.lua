pcall(function() vim.loader.enable() end)

-- Set leader early
vim.g.mapleader = " "

-- Plugins (Vim-Plug)
require("plugins").setup()   -- calls plug#begin/Plug list/plug#end

-- Core config
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.utils")      -- helper functions + user commands

-- Per-plugin config (pcall guarded)
local function safe(mod) local ok,_=pcall(require,mod); if not ok then return end end
safe("plugins.colors")
safe("plugins.lualine")
safe("plugins.nvim-tree")
safe("plugins.hop")
safe("plugins.autopairs")
safe("plugins.comment")
safe("plugins.gitsigns")
safe("plugins.luasnip")
safe("plugins.cmp")
safe("plugins.spectre")
safe("plugins.telescope")
safe("plugins.treesitter")
safe("plugins.project")
safe("plugins.neogit")
safe("plugins.whichkey")
safe("plugins.orgmode")
safe("plugins.lsp")
safe("plugins.null-ls")


vim.api.nvim_create_user_command('ReloadConfig', function()
  for name,_ in pairs(package.loaded) do
    if name:match('^config') or name:match('^plugins') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath('config') .. '/init.lua')
  print('Config reloaded')
end, {})

vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
