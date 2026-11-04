return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Spectre",
  keys = {
    { "<leader>S", function() require("spectre").open() end, desc = "Open Spectre" },
    { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Spectre word" },
    { "<leader>sw", function() require("spectre").open_visual() end, mode = "v", desc = "Spectre selection" },
  },
  opts = {
    highlight = { search = "DiffAdd", replace = "DiffChange" },
    mapping = {
      ["toggle_line"] = { map = "t", cmd = "<Cmd>lua require('spectre').toggle_line()<CR>", desc = "Toggle result line" },
      ["enter_replace_mode"] = { map = "r", cmd = "<Cmd>lua require('spectre.actions').enter_replace_mode()<CR>", desc = "Enter replace mode" },
    },
    find_engine = { ["rg"] = { cmd = "rg", args = { "--vimgrep", "--hidden" } } },
  },
}
