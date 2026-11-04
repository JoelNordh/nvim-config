return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.keymap.set("i", "<C-A>", 'copilot#Accept("\\<CR>")', { expr = true, silent = true, replace_keycodes = false, desc = "Copilot: accept" })
    vim.keymap.set("i", "<C-N>", "copilot#Next()", { expr = true, silent = true, desc = "Copilot: next suggestion" })
    vim.keymap.set("i", "<C-P>", "copilot#Previous()", { expr = true, silent = true, desc = "Copilot: previous suggestion" })
    vim.keymap.set("i", "<C-X>", "copilot#Dismiss()", { expr = true, silent = true, desc = "Copilot: dismiss" })
  end,
}
