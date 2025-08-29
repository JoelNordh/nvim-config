-- nvim-surround – aktiverar standardmappings: ys / cs / ds
local ok, surround = pcall(require, "nvim-surround")
if not ok then return end

surround.setup({
  -- tom = defaults; lägg overrides här om du vill
  -- exempel: keymaps = { insert = "ys", visual = "S", delete = "ds", change = "cs" }
})
-- Snabb sanity-check:
-- :verbose nmap ys   -> ska visa mapping från nvim-surround
