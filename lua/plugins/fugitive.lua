return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit" },
  init = function()
    vim.g.fugitive_diff_vertical = 1
  end,
}
