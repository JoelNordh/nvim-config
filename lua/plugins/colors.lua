return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000, -- load before other UI plugins need a colorscheme
  opts = {
    style = "storm",
    terminal_colors = true,
    styles = { comments = { italic = true } },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)

    local flag = os.getenv("HOME") .. "/.config/nvim/.outdoor-mode"
    if vim.fn.filereadable(flag) == 1 then
      vim.o.background = "light"
      vim.cmd("colorscheme tokyonight-day")
    else
      vim.o.background = "dark"
      vim.opt.guifont = "FiraCode Nerd Font:h12"
      vim.cmd("colorscheme tokyonight") -- loads "storm" thanks to setup() above
    end
  end,
}
