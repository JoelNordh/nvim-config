return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode", -- :ZenMode itself toggles (opens if closed, closes if open)
  keys = {
    { "<leader>zz", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
  },
  opts = {
    window = { width = 0.85 },
  },
}
