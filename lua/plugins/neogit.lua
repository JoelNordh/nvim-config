return {
  "NeogitOrg/neogit",
  dependencies = { "nvim-lua/plenary.nvim", "tpope/vim-fugitive" },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit: open status" },
  },
  opts = {},
}
