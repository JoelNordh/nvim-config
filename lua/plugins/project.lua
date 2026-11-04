return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = {
    detection_methods = { "pattern" },
    patterns = { ".git" },
    manual_mode = false,
    exclude_dirs = {},
    show_hidden = false,
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    -- Registers the :Telescope projects picker once telescope is loaded.
    local ok, telescope = pcall(require, "telescope")
    if ok then pcall(telescope.load_extension, "projects") end
  end,
}
