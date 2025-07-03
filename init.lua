-- Specify the directory for Vim-Plug plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- Plugins
Plug('folke/tokyonight.nvim')                 -- color Scheme
Plug('nvim-tree/nvim-tree.lua')               -- File explorer
Plug('nvim-lualine/lualine.nvim')             -- Status line
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-project.nvim')
Plug('ahmedkhalf/project.nvim')
Plug('nvim-lua/plenary.nvim')                 -- Telescope dependency
Plug('hrsh7th/nvim-cmp')                      -- Autocompletion
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('L3MON4D3/LuaSnip')                      -- Snippet engine
Plug('saadparwaiz1/cmp_luasnip')
Plug('neovim/nvim-lspconfig')                 -- LSP config
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'}) -- Syntax highlighting
Plug('numToStr/Comment.nvim')                 -- Comment toggling
Plug('lewis6991/gitsigns.nvim')               -- Git integration
Plug('windwp/nvim-autopairs')                 -- Auto close brackets
Plug('kyazdani42/nvim-web-devicons')          -- Icons for UI enhancements
Plug 'nvim-pack/nvim-spectre'                 -- Search and replace in buffer
Plug('phaazon/hop.nvim')                      -- HopAnywhere
Plug('t9md/vim-choosewin')                    -- Window switching
Plug('NeogitOrg/neogit')
Plug('jceb/vim-orgmode')
Plug('nvim-neotest/nvim-nio')
Plug('williamboman/mason.nvim')             -- LSP Server & Tool Installer
Plug('williamboman/mason-lspconfig.nvim')  -- LSP Server & Tool Installer Integration
Plug('jose-elias-alvarez/null-ls.nvim')    -- For formatters and linters via LSP
Plug('rafamadriz/friendly-snippets')
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug('tpope/vim-fugitive')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('folke/which-key.nvim') 
Plug 'lervag/vimtex'
Plug('kylechui/nvim-surround')
vim.call('plug#end')

-- General settings
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_quickfix_mode = 0

-- Theme settings for indoor mode and outdoor mode
local outdoor_mode_flag = os.getenv("HOME") .. "/.config/nvim/.outdoor-mode"

if vim.fn.filereadable(outdoor_mode_flag) == 1 then
  vim.o.background = "light"

  vim.cmd('colorscheme tokyonight-day')

else
  vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_enable_italic = true
  vim.g.tokyonight_terminal_colors = true
  vim.opt.guifont = "FiraCode Nerd Font:h12"
  vim.g.fugitive_diff_vertical = 1
  vim.cmd('colorscheme tokyonight')
end

-- Global remaps for better Swedish integration 
-- Helper to remap ä and ö to diff hunks and similar
local function remap_bracket_motions()
  local motions = {
    -- ['new_key'] = 'original_key'
    ['ä'] = ']',
    ['ö'] = '[',
  }

  for new, orig in pairs(motions) do
    for _, suffix in ipairs({ 'c', 'd', 'e', 'g', 'l', 'q' }) do
      local new_key = new .. suffix
      local orig_key = orig .. suffix

      vim.keymap.set('n', new_key, orig_key, { noremap = true, silent = true, desc = 'Bracket motion ' .. orig_key })
    end
  end
end

remap_bracket_motions()


-- Own functions
-- Switch between cpp and hpp files. Possible to extend by adding more extensons
function _G.switch_cpp_hpp()
  -- Get the base name (without extension) and the current file extension
    local current_file = vim.fn.expand('%:r')  -- Base name (e.g., 'file' from 'file.cpp')
    local current_ext = vim.fn.expand('%:e')  -- Current extension (e.g., 'cpp')

    -- Define the extensions to switch between
    local extensions = { cpp = 'hpp', hpp = 'cpp' }

    -- Find the alternate extension
    local alternate_ext = extensions[current_ext]

    -- If the alternate extension exists, open the corresponding file
    if alternate_ext and vim.fn.filereadable(current_file .. '.' .. alternate_ext) == 1 then
        vim.cmd('edit ' .. current_file .. '.' .. alternate_ext)
    else
        print("No alternate file found for: " .. current_file .. "." .. current_ext)
    end
 end

-- Open file at location:
function OpenFileAtLine()
  local line = vim.fn.getline('.') -- Get the current line
  local file_path, line_number = line:match("([^:]+):(%d+):")
  if file_path and line_number then
    vim.cmd("e " .. file_path)  -- Open the file in a new buffer
      vim.cmd(line_number)       -- Jump to the specified line
  elseif file_path then
    vim.cmd("e " .. file_path)
  else
        print("No valid file path and line number found on this line")
  end
end

-- ** REMOVE this clang-format autocmd - we will use null-ls **
-- Clang formating upon saving
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = {"*.cpp", "*.hpp", "*.c", "*.h"},
--     callback = function()
--         local save_cursor = vim.fn.getpos(".")
--         vim.cmd("silent! %!clang-format")
--         vim.fn.setpos(".", save_cursor)
--     end,
-- })

require("ibl").setup()

-- EditConfig command
vim.api.nvim_create_user_command(
'EditConfig',
    function()
        vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/init.lua')
    end,
    {}
)

vim.api.nvim_create_user_command(
  'EditSnippets',
    function()
      vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/snippets/.')
  end,
  {}
)

vim.api.nvim_create_user_command(
  'EditLuaSnippets',
    function()
      vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/lua/snippets/.')
  end,
  {}
)

-- Keybindings
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>fw', function()
  require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })
end, { desc = "Live grep word under cursor" })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})
vim.keymap.set('n', '<leader>fa', ':lua switch_cpp_hpp()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>o', ':lua OpenFileAtLine()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bo', ':bufdo if bufname("%") != "" && bufname("%") !~ "NvimTree" | bdelete | endif<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ha', ":HopWordMW<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>hl', ":Hop:HopAnywhereCurrentLine<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ww', ":ChooseWin<CR>", { noremap = true, silent = true })

vim.keymap.set('v', '<leader>b(', function() SurroundWith('()') end, { noremap = true, silent = true, desc = "Surround with ()" })
vim.keymap.set('v', '<leader>b{', function() SurroundWith('{}') end, { noremap = true, silent = true, desc = "Surround with {}" })
vim.keymap.set('v', '<leader>b[', function() SurroundWith('[]') end, { noremap = true, silent = true, desc = "Surround with []" })


-- vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = ' Git Blame Line' })
-- Ctrl-P bindings:
vim.api.nvim_set_keymap('n', '<C-p>p', ':Telescope projects<CR>', { noremap = true, silent = true })

-- Lualine setup
require('lualine').setup()

-- Nvim-tree setup
require('nvim-tree').setup({
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  sync_root_with_cwd = true,
})

require('hop').setup()

-- Autopairs setup
require('nvim-autopairs').setup()

-- Comment.nvim setup
require('Comment').setup()

-- Gitsigns setup
require('gitsigns').setup()

local luasnip = require('luasnip') -- <---  Move this line HERE, before cmp.setup
      
vim.lsp.set_log_level("debug") -- Or "trace" for more verbose logging

    
luasnip.setup({
})
require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/snippets"})
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
--function ReloadUserSnippets()
--  local luasnip_vscode_loader = require("luasnip.loaders.from_vscode")
--  luasnip_vscode_loader.load({ paths = { vim.fn.expand("~/.config/nvim/snippets") } }) -- Re-load from your snippets directory
--  vim.notify("User snippets reloaded!", vim.log.levels.INFO, { title = "LuaSnip" }) -- Optional: Notify user
--end
      
--vim.api.nvim_create_user_command('ReloadSnippets', ReloadUserSnippets, { desc = 'Reload User Snippets from ~/.config/nvim/snippets/' })

    
-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback() -- Insert a tab character
    end
  end, { 'i', 's' }), -- Apply to insert and select modes
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback() -- Insert a tab character
    end
  end, { 'i', 's' }), -- Apply to insert and select modes
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'npm' },
    },
})

-- Search and replace:

-- Spectre setup
require('spectre').setup({
    highlight = {
        search = "DiffAdd", -- Highlight group for search terms
        replace = "DiffChange", -- Highlight group for replacement terms
    },
    mapping = {
        ['toggle_line'] = {
            map = "t", -- Toggle a line in the result
            cmd = "<Cmd>lua require('spectre').toggle_line()<CR>",
            desc = "Toggle result line"
        },
        ['enter_replace_mode'] = {
            map = "r", -- Enter replace mode
            cmd = "<Cmd>lua require('spectre.actions').enter_replace_mode()<CR>",
            desc = "Enter replace mode"
        },
    },
    find_engine = {
        ["rg"] = { -- Use ripgrep as the search engine
            cmd = "rg",
            args = { "--vimgrep", "--hidden" },
        },
    },
})

-- Keybindings for Spectre
vim.keymap.set('n', '<leader>S', function()
    require('spectre').open()
end, { desc = "Open Spectre for search and replace" })

vim.keymap.set('n', '<leader>sw', function()
    require('spectre').open_visual({ select_word = true })
end, { desc = "Search and replace word under cursor" })

vim.keymap.set('v', '<leader>sw', function()
    require('spectre').open_visual()
end, { desc = "Search and replace selection" })

-- LSP configuration
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig') -- Require mason-lspconfig
local mason = require('mason') -- Require mason

mason.setup({}) -- Basic mason setup

-- mason_lspconfig.setup {  -- Mason-lspconfig setup
--     ensure_installed = { 'clangd' }, -- Ensure clangd is installed (or install it)
--     automatic_installation = true, -- Automatically install missing servers
-- }

lspconfig.ts_ls.setup({
  capabilities = {
     },
    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  })
lspconfig.pyright.setup{}   -- Example for Python
lspconfig.cssls.setup{
   filetypes = { "css", "scss" },
}  -- Add other LSP servers as needed

lspconfig.jsonls.setup({})

lspconfig.clangd.setup({
    -- cmd is not needed as mason will handle it
    -- cmd = { "clangd", "--compile-commands-dir=x86" }, -- Specify the directory with compile_commands.json
    filetypes = { "c", "cpp", "objc", "objcpp" },    -- Enable for C/C++ files
    root_dir = lspconfig.util.find_git_ancestor, -- Or lspconfig.util.root_pattern('.git') if you prefer simpler root detection
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()), -- LSP features
    on_attach = function(client, bufnr)
        -- Keybindings for LSP
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'lf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'v', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.keymap.set('n', '<leader>jb', '<cmd>Telescope jumplist<CR>', { desc = "Show jump list" });
    end,
  init_options = {
        compilationDatabasePath = vim.fn.getcwd() .. "/x86", -- Point to your x86 directory where compile_commands.json is
    },
})

-- ** null-ls setup for formatting **
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

-- 1. DEFINE THE AUTOCMD GROUP
--    This creates the "LspFormat" group. The `clear = true` option is crucial
--    as it removes all previously defined autocommands in this group,
--    preventing duplicates when you reload your config.
vim.api.nvim_create_augroup("LspFormat", { clear = true })


null_ls.setup({
  sources = {
    -- For c, C++, etc
    formatting.clang_format.with({
      -- Add extra_args if you need to point to a specific .clang_format file style
      -- For example: extra_args = {"--style=file:/path/to/your/.clang_format"}
    }),

    -- For TSX, js, CSS, Json etc.
    formatting.prettier.with({
      -- you can specify a custom config file like this:
      -- extra_args = {"--config", "/path/to/your/.prettierrc"},
    }),

    -- you can add linters here as well, for example: 
    -- require("null-ls").builtins.diagnistics.eslint,
  },

  -- This is the key part: it attaches the formatter to the buffer on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = "LspFormat", buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "LspFormat",
        buffer = bufnr, 
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

-- Treesitter setup
require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "cpp", "lua", "python", "javascript", "html", "css", "tsx", "scss", "json" },
    highlight = {
        enable = true,
    },
    indent = {
      enable = true,
    }
})
require('telescope').setup{
  defaults = {
    mappings = {
      i = { -- For insert mode
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,       
      },
      n = { -- For normal mode
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
  pickers = {
    buffers = {
      -- Add mappings specifically for the buffers picker
      mappings = {
        i = {
          -- Map <C-d> to delete marked buffers in insert mode within the picker
        },
        n = {
          -- Map <C-d> to delete marked buffers in normal mode within the picker
        },
      },
      -- Optional: Filter out buffers you typically don't want to close
      -- ignore_buffer_fn = function(bufnr)
      --   -- Example: ignore buffers whose name starts with 'NvimTree'
      --   return vim.fn.bufname(bufnr):match('^NvimTree') ~= nil
      -- end,
    },
  },
  extensions = {
    require("telescope.themes").get_dropdown {

    }
  }
}

require('project_nvim').setup({
detection_methods = { "pattern" }, -- Use pattern matching only
  patterns = { ".git" }, -- Look for .git to detect projects
  manual_mode = false, -- Automatically detect projects
  exclude_dirs = {}, -- Add directories to ignore if needed
  show_hidden = false, -- Set to true if you want hidden directories to be scanned
})

--neogit
require("neogit").setup()

-- Load the projects extension for Telescope
require('telescope').load_extension('projects')
require('telescope').load_extension("ui-select")

require('nvim-surround').setup({

})



-- *****************************
-- vim-orgmode Configuration
-- *****************************

-- Configuration
vim.g.org_todo_keywords = { 'TODO', 'NEXT', 'WAITING', '|', 'DONE', 'CANCELLED' }
vim.g.org_use_default_key_mappings = 0 -- Disable default mappings

-- Enable folding (important for orgmode)
vim.opt.foldmethod = 'syntax'
vim.opt.foldlevelstart = 99   -- Start unfolded

-- Custom Key Mappings (Adjust to your preference)
vim.keymap.set('n', '<leader>ot', ':OrgToggleTodo<CR>', { desc = 'Org: Toggle TODO' })
vim.keymap.set('n', '<leader>op', ':OrgPromote<CR>', { desc = 'Org: Promote Heading' })
vim.keymap.set('n', '<leader>od', ':OrgDemote<CR>', { desc = 'Org: Demote Heading' })
vim.keymap.set('n', '<leader>oi', ':OrgInsertHeadingBelow<CR>', { desc = 'Org: Insert Heading Below' })

-- You can add more mappings as you learn orgmode features.  See the documentation
--   with `:help orgmode` for available commands.
-- *****************************
-- End vim-orgmode Configuration
-- *****************************


-- Place this after your keybindings are defined
require('which-key').setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
})
