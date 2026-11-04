-- Generic (plugin-agnostic) autocmds go here.

-- Spellcheck is on globally (options.lua) for accessibility reasons, but it's
-- just noise in UI/utility buffers, so turn it back off there.
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "NvimTree", "TelescopePrompt", "TelescopeResults", "help", "lazy",
    "mason", "noice", "checkhealth", "neo-tree", "neogit*", "fugitive",
    "DiffviewFiles", "qf", "notify", "startuptime",
  },
  callback = function() vim.opt_local.spell = false end,
})
