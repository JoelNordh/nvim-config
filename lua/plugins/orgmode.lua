-- nvim-orgmode (replaces the old vimscript jceb/vim-orgmode).
-- Manages its own treesitter `org` grammar (separate from nvim-treesitter),
-- installed/updated automatically via the `build` step below.
local org_dir = vim.fn.expand("~/org")

return {
  "nvim-orgmode/orgmode",
  ft = { "org" },
  build = ":Org install_treesitter_grammar",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    vim.fn.mkdir(org_dir, "p")

    require("orgmode").setup({
      org_agenda_files = org_dir .. "/**/*",
      org_default_notes_file = org_dir .. "/refile.org",
      org_todo_keywords = { "TODO", "NEXT", "WAITING", "|", "DONE", "CANCELLED" },
      -- Keep muscle memory from the old vim-orgmode keymaps where they don't
      -- collide with nvim-orgmode's own (saner) defaults.
      mappings = {
        org = {
          org_todo = "<leader>ot",
          org_todo_prev = "<leader>oT",
          org_do_promote = "<leader>op",
          org_do_demote = "<leader>od",
          org_insert_heading_respect_content = "<leader>oi",
        },
      },
    })
  end,
}
