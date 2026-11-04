-- nvim-surround – enables default mappings: ys / cs / ds
-- Loaded on VeryLazy (not `keys`) because its mappings rely on
-- vim.o.operatorfunc, which doesn't lend itself to precise key triggers.
return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {
    -- empty = defaults; add overrides here if needed
    -- e.g.: keymaps = { insert = "ys", visual = "S", delete = "ds", change = "cs" }
  },
}
