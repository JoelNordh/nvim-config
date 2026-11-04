-- Obsidian vault support. Scoped to markdown files inside the vault only
-- (via `cond`), so editing unrelated markdown elsewhere is unaffected.
local vault_dir = vim.fn.expand("~/Obsidian")

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cond = function()
    local path = vim.fn.expand("%:p")
    return path:find(vault_dir, 1, true) ~= nil
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    vim.fn.mkdir(vault_dir, "p")

    require("obsidian").setup({
      workspaces = {
        { name = "vault", path = vault_dir },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      -- Keep notes editable as plain markdown elsewhere; only conceal
      -- obsidian-specific syntax (links, etc.) inside the vault itself.
      ui = { enable = true },
    })

    local opts = { desc = "Obsidian", noremap = true, silent = true }
    vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", opts)
    vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", opts)
    vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", opts)
    vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", opts)
    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", opts)
    vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianFollowLink<CR>", opts)
    vim.keymap.set("n", "<leader>ota", "<cmd>ObsidianTags<CR>", opts)
  end,
}
