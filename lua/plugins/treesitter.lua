return {
  "nvim-treesitter/nvim-treesitter",
  -- Pinned to `master`: the `main` branch is a full incompatible rewrite that
  -- requires Neovim 0.12+ (nightly). We're on 0.11.5, and `master` is the
  -- officially-supported backward-compat branch using the `configs` API below.
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" } },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "cpp", "lua", "python", "javascript", "html", "css", "tsx", "scss", "json",
        -- added for scripting / product-management note-taking workflows
        "bash", "yaml", "toml", "markdown", "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        },
      },
    })
  end,
}
