return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
  },
  opts = {
    update_focused_file = { enable = true, update_cwd = true },
    sync_root_with_cwd = true,
  },
}
