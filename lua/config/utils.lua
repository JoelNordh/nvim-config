
-- Swedish integration for bracket motions
local function remap_bracket_motions()
  local motions = { ['ä'] = ']', ['ö'] = '[' }
  for new, orig in pairs(motions) do
    for _, suffix in ipairs({ 'c', 'd', 'e', 'g', 'l', 'q' }) do
      local new_key = new .. suffix
      local orig_key = orig .. suffix
      vim.keymap.set('n', new_key, orig_key,
        { noremap = true, silent = true, desc = 'Bracket motion ' .. orig_key })
    end
  end
end
remap_bracket_motions()

-- C++/header switch
function _G.switch_cpp_hpp()
  local current_file = vim.fn.expand('%:r')
  local current_ext  = vim.fn.expand('%:e')
  local extensions   = { cpp = 'hpp', hpp = 'cpp' }
  local alt          = extensions[current_ext]
  if alt and vim.fn.filereadable(current_file .. '.' .. alt) == 1 then
    vim.cmd('edit ' .. current_file .. '.' .. alt)
  else
    print("No alternate file found for: " .. current_file .. "." .. current_ext)
  end
end

-- Open file:path:line from current line
function OpenFileAtLine()
  local line = vim.fn.getline('.')
  local file_path, line_number = line:match("([^:]+):(%d+):")
  if file_path and line_number then
    vim.cmd("e " .. file_path)
    vim.cmd(line_number)
  elseif file_path then
    vim.cmd("e " .. file_path)
  else
    print("No valid file path and line number found on this line")
  end
end

-- User commands
vim.api.nvim_create_user_command('EditConfig', function()
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/init.lua')
end, {})

vim.api.nvim_create_user_command('EditSnippets', function()
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/snippets/.')
end, {})

vim.api.nvim_create_user_command('EditLuaSnippets', function()
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/lua/snippets/.')
end, {})
