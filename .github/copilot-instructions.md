# Copilot instructions for this repo

This is a personal Neovim configuration (Lua, loaded as `~/.config/nvim`), not an
application with a build/test/lint pipeline. There is no package manager, compiler,
or test suite — validate changes by reasoning about the Lua/Neovim API and, where
possible, by sourcing the config headlessly, e.g.:
`nvim --headless -c "lua require('lazy').sync({wait=true})" -c "qa"` to install/sync
plugins and surface spec errors, or
`nvim --headless -c "lua require('lazy').load({plugins={'<name>'}})" -c "qa!"` to
force-load one plugin spec and catch config-function errors without opening a UI.
`:ReloadConfig` inside a running instance reloads `config.*` modules only (see below).

## Plugin manager: lazy.nvim

Plugins are managed by **lazy.nvim**, bootstrapped in `lua/config/lazy.lua` and
required from `init.lua`. There is no central plugin list: `lazy.nvim` auto-imports
every file under `lua/plugins/` as a spec via `{ import = "plugins" }`.

- **Each file in `lua/plugins/` returns one lazy.nvim spec (or a list of specs)**
  combining the plugin declaration, its lazy-load trigger, and its config — e.g.
  `lua/plugins/telescope.lua`, `lua/plugins/lsp.lua` (three specs: mason,
  mason-lspconfig, nvim-lspconfig). **New plugins must follow this pattern**: add a
  new `lua/plugins/<name>.lua` file; don't add plugins anywhere else.
- **Always give a plugin a real lazy-load trigger** (`event`, `cmd`, `ft`, or `keys`)
  unless it must load at startup (e.g. colorscheme, `nvim-notify`, `auto-session`
  use `lazy = false`). Pick the narrowest trigger that fits: `ft` for
  filetype-specific tools (`vimtex` → `tex`, `nvim-orgmode` → `org`), `cmd`/`keys` for
  on-demand tools (`diffview.nvim`, `nvim-spectre`), `event = "InsertEnter"` for
  completion-adjacent plugins, `event = "VeryLazy"` as a catch-all for things that
  should defer but don't fit a narrower trigger (and for plugins like
  `nvim-surround` whose mappings use `operatorfunc` and don't lend themselves to a
  precise `keys` trigger).
- **Never call `require()` on a lazily-loaded plugin's module at the top level of a
  spec table** (e.g. inside a static `opts = {...}` table) — that runs at
  spec-import time, before the plugin is even cloned, and defeats lazy loading. Use
  `opts = function() ... return opts end` or do it inside `config = function() ... end`
  instead (see `lua/plugins/telescope.lua` for the pattern).
- Plugin-specific keymaps belong in that plugin's own spec file via the `keys` table
  (lazy.nvim creates the mapping and loads the plugin on first use) or inside
  `config`/`init`, not in `lua/config/keymaps.lua`.
- `lazy-lock.json` at the repo root pins installed plugin commits — commit it
  alongside spec changes so installs stay reproducible.

## Repo layout and load order

- `init.lua` load order: `config.options` (plugin-agnostic) → `config.lazy`
  (bootstraps lazy.nvim, imports `plugins/`) → `config.keymaps` → `config.autocmds`
  → `config.utils` → `service_explorer` (custom plugin).
- `lua/config/utils.lua` holds misc custom helper functions and user commands
  (e.g. `EditConfig`, `switch_cpp_hpp`, `OpenFileAtLine`). Add new one-off helpers
  and `vim.api.nvim_create_user_command` definitions here rather than scattering
  them across plugin files.
- `lua/config/keymaps.lua` only holds core, plugin-agnostic keymaps (leader is
  `<space>`, set in `init.lua`). LSP `on_attach` keymaps live in `lua/plugins/lsp.lua`.
- `lua/snippets/` (Lua, LuaSnip format) and `snippets/` (JSON, friendly-snippets
  format) both hold snippets — check which format a filetype uses before adding new
  ones (`lua/snippets/all.lua` loads globally; `snippets/*.json` is filetype-keyed by
  filename, registered via `snippets/package.json`). Both are loaded by
  `lua/plugins/luasnip.lua`, along with `friendly-snippets`' own bundled snippets.
- `lua/service_explorer/` is a standalone custom plugin for exploring a service
  dependency JSON file (`SeedHawkGateway.json`, path hardcoded in `init.lua`). It
  exposes `:ListServices`, `:ShowService`, `:GetProvider`, `:DrawDependencies`,
  `:DrawDependenciesGraph` (the last shells out to Graphviz `dot`). See its
  `README.md` for details; keep that README in sync when changing commands.
- `plugged/` is a leftover from the previous vim-plug setup and is no longer used —
  lazy.nvim installs into `stdpath("data") .. "/lazy"` instead. Safe to delete.

## Conventions

- LSP servers are configured in `lua/plugins/lsp.lua` via `lspconfig.<server>.setup{}`
  with a single shared `on_attach` for keymaps and a shared `capabilities` built from
  `cmp_nvim_lsp`; `clangd` gets its own `on_attach` wrapper to add one extra keymap.
  Servers are kept installed via `mason-lspconfig`'s `ensure_installed` list — add new
  servers there (not just to `lspconfig`) so Mason actually installs the binary.
- Formatting is wired through `conform.nvim` (`lua/plugins/conform.lua`,
  `format_on_save` + `formatters_by_ft`); linting through `nvim-lint`
  (`lua/plugins/lint.lua`, `linters_by_ft`) for filetypes that don't already get
  diagnostics from an LSP server (e.g. skip adding a linter for Python — `ruff`'s LSP
  already provides those diagnostics).
- Keymap definitions generally pass `{ noremap = true, silent = true, desc = "..." }`;
  match this style for new mappings so which-key picks up a label automatically.
- Indentation defaults are 2-space, `expandtab` (see `lua/config/options.lua`).
- Spellcheck (`o.spell`) is on globally by default (`lua/config/options.lua`) for
  accessibility, and turned back off for UI/utility buffer filetypes via a
  `FileType` autocmd in `lua/config/autocmds.lua` — extend that pattern list
  rather than disabling `o.spell` itself if a new UI plugin gets noisy.
- Non-LSP CLI tools used by `conform.nvim`/`nvim-lint` (formatters/linters, not
  language servers) are auto-installed via `mason-tool-installer.nvim`
  (`lua/plugins/mason-tool-installer.lua`'s `ensure_installed`) — add new ones
  there, separately from `lsp.lua`'s `mason-lspconfig` list.
- Plugins that should only activate for files under a specific directory (e.g.
  `obsidian.nvim`, scoped to the `~/Obsidian` vault) use a `cond` function
  checking the buffer path, combined with a broad `ft` trigger — this keeps
  other markdown files unaffected. Note `cond`-gated plugins aren't installed
  by a plain `lazy.sync()` until `cond` is true at least once; force-install
  with `require('lazy').install({plugins={'<name>'}})` or open a matching file
  once to validate.

## Keymap cheatsheet

`docs/cheatsheet.md` documents every keymap/command in this config and is the
source for `docs/cheatsheet.pdf` (built via pandoc, see
`docs/build-cheatsheet.sh` or `:BuildCheatsheet`). **When adding, removing, or
rebinding a keymap/command in any `lua/plugins/*.lua` or `lua/config/*.lua`
file, update the matching row in `docs/cheatsheet.md` in the same change**,
then run `:BuildCheatsheet` (or `docs/build-cheatsheet.sh`) to refresh the PDF.
The PDF itself is gitignored (regenerable build artifact); only the Markdown
source is tracked.
