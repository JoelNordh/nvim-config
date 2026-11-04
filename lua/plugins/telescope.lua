return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    { "<leader>fw", function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
      end, desc = "Live grep word under cursor" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
    { "<leader>fz", function()
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ winblend = 10, previewer = true }))
      end, desc = "Fuzzy find in current buffer" },
    { "<leader>fs", function() require("telescope.builtin").grep_string() end, desc = "Search string under cursor" },
    { "<C-p>p", "<cmd>Telescope projects<CR>", desc = "Find projects" },
  },
  -- opts as a function defers require("telescope.actions") until the plugin
  -- actually loads, instead of running at spec-import time.
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          i = { ["<C-j>"] = actions.move_selection_next, ["<C-k>"] = actions.move_selection_previous },
          n = { ["<C-j>"] = actions.move_selection_next, ["<C-k>"] = actions.move_selection_previous },
        },
      },
      pickers = { buffers = { mappings = { i = {}, n = {} } } },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension, "ui-select")
  end,
}
