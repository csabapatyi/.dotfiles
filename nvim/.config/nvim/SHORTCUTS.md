# Neovim Keyboard Shortcuts

> Leader key: `<Space>`

## General

| Shortcut | Mode | Description |
|---|---|---|
| `<Esc>` | Normal | Clear search highlights |
| `<Esc><Esc>` | Terminal | Exit terminal mode |
| `<C-h>` | Normal | Move focus to the left window |
| `<C-j>` | Normal | Move focus to the lower window |
| `<C-k>` | Normal | Move focus to the upper window |
| `<C-l>` | Normal | Move focus to the right window |

## File Explorer (Neo-tree)

| Shortcut | Mode | Description |
|---|---|---|
| `<C-e>` | Normal | Toggle Neo-tree file explorer |
| `\` | Normal | Reveal current file in Neo-tree |

## Search (Telescope)

| Shortcut | Mode | Description |
|---|---|---|
| `<leader>sf` | Normal | Search files |
| `<leader>sg` | Normal | Search by grep (live) |
| `<leader>sw` | Normal, Visual | Search current word |
| `<leader>sh` | Normal | Search help tags |
| `<leader>sk` | Normal | Search keymaps |
| `<leader>ss` | Normal | Search Telescope builtins |
| `<leader>sd` | Normal | Search diagnostics |
| `<leader>sr` | Normal | Resume last search |
| `<leader>sc` | Normal | Search commands |
| `<leader>s.` | Normal | Search recent files |
| `<leader>s/` | Normal | Search (grep) in open files |
| `<leader>sn` | Normal | Search Neovim config files |
| `<leader>/` | Normal | Fuzzy search in current buffer |
| `<leader><leader>` | Normal | Find existing buffers |

## LSP (Language Server Protocol)

| Shortcut | Mode | Description |
|---|---|---|
| `grn` | Normal | Rename symbol |
| `gra` | Normal, Visual | Code action |
| `grr` | Normal | Go to references |
| `gri` | Normal | Go to implementation |
| `grd` | Normal | Go to definition |
| `grD` | Normal | Go to declaration |
| `grt` | Normal | Go to type definition |
| `gO` | Normal | List document symbols |
| `gW` | Normal | List workspace symbols |
| `<leader>th` | Normal | Toggle inlay hints |
| `<leader>f` | Normal, Visual | Format buffer |

## Diagnostics

| Shortcut | Mode | Description |
|---|---|---|
| `<leader>q` | Normal | Open diagnostic quickfix list |
| `[d` | Normal | Go to previous diagnostic |
| `]d` | Normal | Go to next diagnostic |

## Autocompletion (blink.cmp)

| Shortcut | Mode | Description |
|---|---|---|
| `<C-y>` | Insert | Accept completion |
| `<C-space>` | Insert | Open completion menu / toggle docs |
| `<C-n>` / `<Down>` | Insert | Select next item |
| `<C-p>` / `<Up>` | Insert | Select previous item |
| `<C-e>` | Insert | Dismiss completion menu |
| `<C-k>` | Insert | Toggle signature help |
| `<Tab>` | Insert | Move to right in snippet |
| `<S-Tab>` | Insert | Move to left in snippet |

## Git (Gitsigns)

| Shortcut | Mode | Description |
|---|---|---|
| `]c` | Normal | Jump to next git change |
| `[c` | Normal | Jump to previous git change |
| `<leader>hs` | Normal | Stage hunk |
| `<leader>hs` | Visual | Stage selected hunk |
| `<leader>hr` | Normal | Reset hunk |
| `<leader>hr` | Visual | Reset selected hunk |
| `<leader>hS` | Normal | Stage entire buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hR` | Normal | Reset entire buffer |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame current line |
| `<leader>hd` | Normal | Diff against index |
| `<leader>hD` | Normal | Diff against last commit |
| `<leader>tb` | Normal | Toggle inline git blame |
| `<leader>tD` | Normal | Toggle inline deleted preview |

## Debugging (DAP)

| Shortcut | Mode | Description |
|---|---|---|
| `<F5>` | Normal | Start / Continue |
| `<F1>` | Normal | Step into |
| `<F2>` | Normal | Step over |
| `<F3>` | Normal | Step out |
| `<F7>` | Normal | Toggle debug UI |
| `<leader>b` | Normal | Toggle breakpoint |
| `<leader>B` | Normal | Set conditional breakpoint |

## Mini.nvim Modules

### mini.ai — Around/Inside Text Objects

| Shortcut | Mode | Description |
|---|---|---|
| `va)` | Normal | Visually select around parentheses |
| `yinq` | Normal | Yank inside next quote |
| `ci'` | Normal | Change inside single quotes |

### mini.surround — Surround Actions

| Shortcut | Mode | Description |
|---|---|---|
| `saiw)` | Normal | Surround add inner word with `()` |
| `sd'` | Normal | Surround delete quotes |
| `sr)'` | Normal | Surround replace `)` with `'` |

## Plugin Management (Lazy.nvim)

| Command | Description |
|---|---|
| `:Lazy` | Open Lazy plugin manager |
| `:Lazy update` | Update all plugins |
| `:Mason` | Open Mason tool installer |
| `:ConformInfo` | Show formatter info for current buffer |

## Supported Languages

| Language | LSP Server | Formatter(s) | Linter(s) |
|---|---|---|---|
| Python | `basedpyright` | `black`, `isort` | `ruff` |
| Go | `gopls` | `goimports`, `gofumpt` | `golangci-lint` |
| Bash | — | `shfmt` | `shellcheck` |
| Lua | `lua_ls` | `stylua` | — |
| Terraform | `terraformls` | `terraform fmt` | `tflint` |
| Ansible | — | — | `ansible-lint` |
| Markdown | `marksman` | — | — |

> **Note:** This config avoids npm-dependent tools. Bash, Ansible, and Markdown
> rely on treesitter for syntax highlighting plus dedicated linters/formatters
> instead of LSP servers. If you have Node.js installed, you can swap in
> `pyright`, `bashls`, `ansiblels`, `prettier`, and `markdownlint` as alternatives.