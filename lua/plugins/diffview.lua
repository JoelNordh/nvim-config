return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview: open" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: file history" },
    { "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "Diffview: close" },
  },
  opts = {},
}
