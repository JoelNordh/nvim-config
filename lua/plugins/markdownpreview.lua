-- This file previously contained invalid Vimscript syntax inside a .lua file
-- and silently failed to load (swallowed by the safe-require pcall), so none
-- of these settings or keymaps were ever actually applied.
return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  ft = { "markdown" },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  init = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_browser = "/snap/bin/firefox"
    vim.g.mkdp_open_ip = "127.0.0.1"
    vim.g.mkdp_port = "" -- empty = pick any free port
    vim.g.mkdp_theme = "dark"
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown preview: toggle" },
    { "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", desc = "Markdown preview: stop" },
  },
}
