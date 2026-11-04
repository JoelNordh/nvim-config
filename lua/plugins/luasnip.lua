return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  lazy = true, -- loaded transitively via nvim-cmp (event = InsertEnter)
  opts = {},
  config = function(_, opts)
    require("luasnip").setup(opts)

    -- Loads any vscode-format snippet package on the runtimepath, which
    -- covers both friendly-snippets and our own `snippets/package.json`.
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Explicit path kept too, in case rtp discovery order ever misses it.
    pcall(require("luasnip.loaders.from_vscode").lazy_load, {
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })
    pcall(require("luasnip.loaders.from_lua").load, {
      paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
    })
  end,
}
