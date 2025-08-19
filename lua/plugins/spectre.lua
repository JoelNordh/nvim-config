
local ok, spectre = pcall(require, 'spectre')
if not ok then return end

spectre.setup({
  highlight = { search = "DiffAdd", replace = "DiffChange" },
  mapping = {
    ['toggle_line'] = { map = "t", cmd = "<Cmd>lua require('spectre').toggle_line()<CR>", desc = "Toggle result line" },
    ['enter_replace_mode'] = { map = "r", cmd = "<Cmd>lua require('spectre.actions').enter_replace_mode()<CR>", desc = "Enter replace mode" },
  },
  find_engine = { ["rg"] = { cmd = "rg", args = { "--vimgrep", "--hidden" } } },
})
