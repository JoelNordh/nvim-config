---
title: "Neovim Config Cheatsheet"
subtitle: "JoelNordh/nvim-config"
author: ""
date: \today
geometry: margin=1.5cm
fontsize: 10pt
colorlinks: true
---

Leader key: **`<Space>`** &nbsp;&nbsp;|&nbsp;&nbsp; Local leader: **`\`** (vimtex default)

## General

| Key | Action |
|---|---|
| `<leader>e` | Toggle file explorer (nvim-tree) |
| `<leader>bo` | Close all buffers except nvim-tree |
| `<leader>ww` | Choose window (vim-choosewin) |
| `<leader>fa` | Switch between `.cpp` / `.hpp` |
| `<leader>cp` | Copy relative file path to clipboard |
| `<leader>cP` | Copy absolute file path to clipboard |
| `<leader>cl` | Copy absolute file path with current line number to clipboard |
| `ää`/`ö`-prefixed motions | Swedish remap of `]`/`[` bracket motions (e.g. `äc` = `]c`) |
| *(automatic)* | `rainbow_csv` rainbow-colors columns in `.csv`/`.tsv` files, no keymaps needed |

## Find & Search (Telescope)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fw` | Live grep word under cursor |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fz` | Fuzzy find in current buffer |
| `<leader>fs` | Search string under cursor |
| `<leader>ft` | Find TODO comments (Telescope) |
| `<C-p>p` | Find projects |
| `<C-j>`/`<C-k>` | Next/previous result (insert & normal mode) |

## Search & Replace (Spectre) / Jump (Hop)

| Key | Action |
|---|---|
| `<leader>S` | Open Spectre (project-wide search/replace) |
| `<leader>sw` | Spectre: search word under cursor / visual selection |
| `t` *(in Spectre)* | Toggle result line |
| `r` *(in Spectre)* | Enter replace mode |
| `<leader>ha` | Hop to word |
| `<leader>hl` | Hop within current line |

## Git

| Key | Action |
|---|---|
| `<leader>gg` | Open Neogit status |
| `<leader>gd` | Diffview: open |
| `<leader>gh` | Diffview: file history |
| `<leader>gc` | Diffview: close |
| `:G` / `:Git` | Fugitive git command |
| *(gutter)* | gitsigns shows add/change/delete signs (no custom keymaps configured) |

## LSP (on file with an attached language server)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | List references |
| `gy` | Go to type definition |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `lf` | Format buffer (LSP) |
| `ca` | Code action (normal & visual) |
| `<leader>jb` | Show jump list *(clangd buffers only)* |

Servers: `clangd` (C/C++), `pyright` + `ruff` (Python), `ts_ls` (JS/TS),
`cssls`, `jsonls`, `yamlls`, `bashls`. Managed via Mason — `:Mason`,
`:MasonInstall <name>`, `:MasonUpdate`.

## Completion & Snippets (nvim-cmp / LuaSnip)

| Key | Action |
|---|---|
| `<Tab>` | Next item / expand or jump snippet |
| `<S-Tab>` | Previous item / jump back in snippet |
| `<C-Space>` / `<C-l>` | Trigger completion manually |
| `<CR>` | Confirm selected completion |
| `:` then `<Tab>` | Command-line completion (paths/commands) |
| `/` or `?` then `<Tab>` | Search completion (buffer words) |

Snippets load from `lua/snippets/*.lua`, `snippets/*.json`, and
`friendly-snippets`. PM-specific templates (markdown only): `prd`, `meeting`,
`decision`, `1pager`, `standup`.

## Formatting & Linting

| Key | Action |
|---|---|
| `<leader>cf` | Format buffer now (conform.nvim) |
| *(on save)* | Auto-format via conform.nvim (falls back to LSP formatter) |
| *(on save/insert-leave)* | Auto-lint via nvim-lint: `shellcheck` (sh), `eslint_d` (js/ts), `vale` (markdown prose/style). Python linting comes from the `ruff` LSP server instead. |
| `:ConformInfo` | Show which formatter will run for this buffer |

All non-LSP formatter/linter CLI tools (`stylua`, `shfmt`, `shellcheck`,
`eslint_d`, `prettier`, `clang-format`, `vale`) auto-install via Mason on
first startup (mason-tool-installer.nvim).

## Treesitter Textobjects & Motions

| Key | Action |
|---|---|
| `af` / `if` | Select around/inside function |
| `ac` / `ic` | Select around/inside class |
| `aa` / `ia` | Select around/inside parameter/argument |
| `]f` / `[f` | Jump to next/previous function start |
| `]c` / `[c` | Jump to next/previous class start |

## Surround & Comment

| Key | Action |
|---|---|
| `ys{motion}{char}` | Add surround (e.g. `ysiw"`) |
| `cs{old}{new}` | Change surround |
| `ds{char}` | Delete surround |
| `S` *(visual)* | Surround selection |
| `gcc` | Toggle line comment |
| `gc{motion}` | Comment over a motion |
| `gbc` / `gb{motion}` | Toggle block comment |

## TODO Comments

| Key | Action |
|---|---|
| `]t` / `[t` | Jump to next/previous TODO/FIXME/NOTE comment |
| `<leader>ft` | List TODOs in Telescope |

## Sessions

| Key | Action |
|---|---|
| `<leader>qs` | Save session for current directory |
| `<leader>ql` | Restore session for current directory |
| *(automatic)* | auto-session restores the session on `cd`/startup |

## AI Assistants

| Key | Action |
|---|---|
| `<C-A>` *(insert)* | Accept Copilot suggestion |
| `<C-N>` / `<C-P>` *(insert)* | Next / previous Copilot suggestion |
| `<C-X>` *(insert)* | Dismiss Copilot suggestion |
| `<leader>cc` | Open CopilotChat |
| `<leader>cq` *(visual)* | Ask CopilotChat about selection |
| `<leader>ca` | CodeCompanion: actions palette |
| `<leader>ct` | CodeCompanion: toggle chat |

## Filetype-specific

| Key | Action |
|---|---|
| `<leader>ot` / `<leader>oT` | Org: cycle TODO state forward / backward *(`.org` files)* |
| `<leader>op` / `<leader>od` | Org: promote / demote heading |
| `<leader>oi` | Org: insert heading below |
| `<leader>oa` | Org: open agenda *(default mapping)* |
| `<leader>oc` | Org: capture *(default mapping)* |
| `<localleader>ll` | Vimtex: compile *(`.tex` files, default mapping)* |
| `<localleader>lv` | Vimtex: view PDF *(default mapping)* |
| `<leader>mp` / `<leader>ms` | Markdown preview: toggle / stop |
| `-ld` *(visual)* | Linediff: start on region |
| `-lr` | Linediff: reset |

## Org-mode (nvim-orgmode, `~/org`)

| Key | Action |
|---|---|
| `<Tab>` / `<S-Tab>` | Cycle fold at headline / cycle all folds |
| `<<` / `>>` | Promote / demote headline |
| `<C-Space>` | Toggle checkbox |
| `<leader>oih` / `<leader>oiT` / `<leader>oit` | Insert heading / TODO heading / TODO heading+content |
| `<leader>or` | Refile headline to another org file |
| `<leader>ox` | Export current file |

## Obsidian (obsidian.nvim, `~/Obsidian` vault, markdown files only)

| Key | Action |
|---|---|
| `<leader>oo` | Open note in the Obsidian app |
| `<leader>on` | Create a new note |
| `<leader>os` | Search notes |
| `<leader>oq` | Quick switch between notes |
| `<leader>ob` | Show backlinks to current note |
| `<leader>ol` | Follow link under cursor |
| `<leader>ota` | Browse tags |
| `gf` | Follow a `[[wiki link]]` under cursor |

## Zen Mode & Spelling

| Key | Action |
|---|---|
| `<leader>zz` | Toggle Zen Mode (distraction-free writing) |
| *(always on)* | Spellcheck is enabled globally (`en_us`); auto-disabled in UI/utility buffers (NvimTree, Telescope, help, etc.) |
| `]s` / `[s` | Jump to next / previous misspelled word |
| `z=` | Suggest spelling corrections |
| `zg` | Add word under cursor to spell dictionary |

## Custom Commands

| Command | Action |
|---|---|
| `:EditConfig` | Open `init.lua` |
| `:EditSnippets` | Open JSON snippets directory |
| `:EditLuaSnippets` | Open Lua snippets directory |
| `:EditCheatsheet` | Open `docs/cheatsheet.md` |
| `:BuildCheatsheet` | Rebuild `docs/cheatsheet.pdf` from the Markdown source |
| `:Cheatsheet` | Open `docs/cheatsheet.pdf` in Evince (builds it first if missing) |
| `:ReloadConfig` | Reload `config.*` Lua modules |
| `:ListServices` | Service Explorer: list services from `SeedHawkGateway.json` |
| `:ShowService <name>` | Service Explorer: show inputs/outputs |
| `:GetProvider` | Service Explorer: find provider of input under cursor |
| `:DrawDependencies <name>` | Service Explorer: ASCII dependency graph |
| `:DrawDependenciesGraph <name>` | Service Explorer: Graphviz PNG dependency graph |

## Theme

Dark theme (`tokyonight`, storm) by default; switches to light
(`tokyonight-day`) automatically if `~/.config/nvim/.outdoor-mode` exists.

\vfill
\footnotesize
*Generated from `docs/cheatsheet.md` — update this file and the plugin specs
under `lua/plugins/` together, then run `docs/build-cheatsheet.sh` to refresh
`docs/cheatsheet.pdf`.*
