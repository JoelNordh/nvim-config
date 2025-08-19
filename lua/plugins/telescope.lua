
local ok, telescope = pcall(require, 'telescope')
if not ok then return end

telescope.setup{
  defaults = {
    mappings = {
      i = { ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous },
      n = { ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous },
    },
  },
  pickers = { buffers = { mappings = { i = {}, n = {} } } },
}
pcall(telescope.load_extension, 'projects')
pcall(telescope.load_extension, 'ui-select')
