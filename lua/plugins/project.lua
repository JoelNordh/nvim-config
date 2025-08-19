
local ok, project = pcall(require, 'project_nvim')
if not ok then return end
project.setup({
  detection_methods = { "pattern" },
  patterns = { ".git" },
  manual_mode = false,
  exclude_dirs = {},
  show_hidden = false,
})
