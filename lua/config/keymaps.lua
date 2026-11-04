
local map = vim.keymap.set

-- NvimTree / buffers
map('n', '<leader>bo',
  ':bufdo if bufname("%") != "" && bufname("%") !~ "NvimTree" | bdelete | endif<CR>',
  { noremap = true, silent = true, desc = "Close all buffers except NvimTree" })

-- Utils
map('n', '<leader>fa', ':lua switch_cpp_hpp()<CR>', { noremap = true, silent = true, desc = "Switch between .cpp/.hpp" })

-- Copy current file path to the clipboard (handy for giving AI tools context)
map('n', '<leader>cp', ':lua copy_path("relative")<CR>', { noremap = true, silent = true, desc = "Copy relative file path" })
map('n', '<leader>cP', ':lua copy_path("absolute")<CR>', { noremap = true, silent = true, desc = "Copy absolute file path" })
map('n', '<leader>cl', ':lua copy_path("line")<CR>', { noremap = true, silent = true, desc = "Copy file path:line" })
