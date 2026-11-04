return {
  "rcarriga/nvim-notify",
  lazy = false,
  priority = 900, -- load early so other plugins' startup notifications use it too
  opts = { timeout = 3000, stages = "fade_in_slide_out" },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end,
}
