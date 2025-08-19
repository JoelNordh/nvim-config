
local ok, nvtree = pcall(require, 'nvim-tree')
if not ok then return end
nvtree.setup({
  update_focused_file = { enable = true, update_cwd = true },
  sync_root_with_cwd = true,
})
