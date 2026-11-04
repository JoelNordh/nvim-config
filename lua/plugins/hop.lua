return {
  "smoka7/hop.nvim", -- phaazon/hop.nvim was archived upstream; this is the maintained fork
  keys = {
    { "<leader>ha", ":HopWordMW<CR>", desc = "Hop to word" },
    { "<leader>hl", function() require("hop").hint_words({ current_line_only = true }) end, desc = "Hop in current line" },
  },
  opts = {},
}
