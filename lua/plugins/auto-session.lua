return {
  "rmagatti/auto-session",
  lazy = false, -- must load at startup to restore the session for the cwd
  keys = {
    { "<leader>qs", "<cmd>SessionSave<CR>", desc = "Session: save" },
    { "<leader>ql", "<cmd>SessionRestore<CR>", desc = "Session: restore" },
  },
  opts = {
    log_level = "error",
    suppressed_dirs = { "~/", "~/Downloads", "/" },
  },
}
