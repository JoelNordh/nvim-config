
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

-- Copy the current file's path to the clipboard -- handy for pasting as
-- context into AI chat tools. `kind`: "relative" | "absolute" | "line"
-- (absolute path with the current line number appended).
function _G.copy_path(kind)
  local path
  if kind == "absolute" then
    path = vim.fn.expand('%:p')
  elseif kind == "line" then
    path = vim.fn.expand('%:p') .. ':' .. vim.fn.line('.')
  else
    path = vim.fn.expand('%:.')
  end
  vim.fn.setreg('+', path)
  vim.fn.setreg('"', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
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

vim.api.nvim_create_user_command('EditCheatsheet', function()
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/docs/cheatsheet.md')
end, {})

-- Regenerates docs/cheatsheet.pdf from docs/cheatsheet.md via pandoc.
vim.api.nvim_create_user_command('BuildCheatsheet', function()
  local config_dir = vim.fn.stdpath('config')
  vim.notify('Building cheatsheet PDF...', vim.log.levels.INFO)
  vim.fn.jobstart({ config_dir .. '/docs/build-cheatsheet.sh' }, {
    cwd = config_dir .. '/docs',
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('Cheatsheet rebuilt: docs/cheatsheet.pdf', vim.log.levels.INFO)
      else
        vim.notify('Cheatsheet build failed (exit ' .. code .. ') — see docs/build-cheatsheet.sh', vim.log.levels.ERROR)
      end
    end,
  })
end, {})

-- Opens docs/cheatsheet.pdf in Evince (falls back to xdg-open), building it
-- first via the same logic as :BuildCheatsheet if it doesn't exist yet.
vim.api.nvim_create_user_command('Cheatsheet', function()
  local config_dir = vim.fn.stdpath('config')
  local pdf_path = config_dir .. '/docs/cheatsheet.pdf'

  local function open_pdf()
    local opener = vim.fn.executable('evince') == 1 and 'evince' or 'xdg-open'
    vim.fn.jobstart({ opener, pdf_path }, { detach = true })
    vim.notify('Opening cheatsheet with ' .. opener, vim.log.levels.INFO)
  end

  if vim.fn.filereadable(pdf_path) == 1 then
    open_pdf()
    return
  end

  vim.notify('Cheatsheet PDF not found, building it first...', vim.log.levels.INFO)
  vim.fn.jobstart({ config_dir .. '/docs/build-cheatsheet.sh' }, {
    cwd = config_dir .. '/docs',
    on_exit = function(_, code)
      if code == 0 then
        open_pdf()
      else
        vim.notify('Cheatsheet build failed (exit ' .. code .. ') — see docs/build-cheatsheet.sh', vim.log.levels.ERROR)
      end
    end,
  })
end, {})

