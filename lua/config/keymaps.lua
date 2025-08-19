
local map = vim.keymap.set

-- Telescope
map('n', '<leader>ff', require('telescope.builtin').find_files, {})
map('n', '<leader>fg', require('telescope.builtin').live_grep, {})
map('n', '<leader>fw', function()
  require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })
end, { desc = "Live grep word under cursor" })
map('n', '<leader>fb', require('telescope.builtin').buffers, {})
map('n', '<leader>fh', require('telescope.builtin').help_tags, {})
vim.api.nvim_set_keymap('n', '<C-p>p', ':Telescope projects<CR>', { noremap = true, silent = true })

-- NvimTree / buffers
map('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
map('n', '<leader>bo',
  ':bufdo if bufname("%") != "" && bufname("%") !~ "NvimTree" | bdelete | endif<CR>',
  { noremap = true, silent = true })

-- Hop
map('n', '<leader>ha', ":HopWordMW<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>hl', function()
  require('hop').hint_words({ current_line_only = true })
end, { noremap = true, silent = true })

-- Choosewin
map('n', '<leader>ww', ":ChooseWin<CR>", { noremap = true, silent = true })

-- Utils
map('n', '<leader>fa', ':lua switch_cpp_hpp()<CR>', {noremap = true, silent = true})
map('n', '<leader>o', ':lua OpenFileAtLine()<CR>', { noremap = true, silent = true })

-- Spectre
map('n', '<leader>S', function() require('spectre').open() end, { desc = "Open Spectre" })
map('n', '<leader>sw', function() require('spectre').open_visual({ select_word = true }) end, { desc = "Spectre word" })
map('v', '<leader>sw', function() require('spectre').open_visual() end, { desc = "Spectre selection" })
