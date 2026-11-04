return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = { "github/copilot.vim", "nvim-lua/plenary.nvim" },
  cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatToggle" },
  keys = {
    { "<leader>cc", function() require("CopilotChat").open() end, desc = "Open Copilot Chat" },
    { "<leader>cq", function() require("CopilotChat").ask() end, mode = "v", desc = "Ask Copilot Chat about selection" },
  },
  opts = {},
}
