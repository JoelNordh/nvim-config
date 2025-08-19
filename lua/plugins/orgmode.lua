
-- vim-orgmode (vimscript plugin) + minimal settings you had
vim.g.org_todo_keywords = { 'TODO', 'NEXT', 'WAITING', '|', 'DONE', 'CANCELLED' }
vim.g.org_use_default_key_mappings = 0
vim.opt.foldmethod = 'syntax'
vim.opt.foldlevelstart = 99

vim.keymap.set('n', '<leader>ot', ':OrgToggleTodo<CR>', { desc = 'Org: Toggle TODO' })
vim.keymap.set('n', '<leader>op', ':OrgPromote<CR>', { desc = 'Org: Promote Heading' })
vim.keymap.set('n', '<leader>od', ':OrgDemote<CR>', { desc = 'Org: Demote Heading' })
vim.keymap.set('n', '<leader>oi', ':OrgInsertHeadingBelow<CR>', { desc = 'Org: Insert Heading Below' })
