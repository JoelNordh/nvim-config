return {
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  keys = {
    { "<leader>ca", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion: actions" },
    { "<leader>ct", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "CodeCompanion: toggle chat" },
  },
  opts = {
    -- Reuses the same GitHub Copilot auth as copilot.vim/CopilotChat.
    strategies = {
      chat = { adapter = "copilot" },
      inline = { adapter = "copilot" },
    },
  },
}
