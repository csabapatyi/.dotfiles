# Neovim Configuration

Personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), customised with gruvbox theme, language support, and sensible defaults.

## Features

- **Theme:** Gruvbox (dark, hard contrast) — matching tmux theme
- **Tabs:** 2 spaces everywhere
- **Search:** Case-insensitive by default (smart-case when uppercase is used)
- **File explorer:** Neo-tree, toggled with `Ctrl+E`
- **Fuzzy finder:** Telescope for files, grep, LSP symbols, and more
- **Autocompletion:** blink.cmp with LuaSnip snippets
- **Autoformat on save:** via conform.nvim
- **Linting:** via nvim-lint (runs on save and insert leave)
- **Debugging:** DAP with Go support out of the box
- **Git integration:** Gitsigns with hunk navigation, staging, and blame
- **Which-key:** Shows pending keybinds as you type

## Supported Languages

| Language   | LSP Server      | Formatter(s)           | Linter(s)       |
|------------|-----------------|------------------------|-----------------|
| Python     | `basedpyright`  | `black`, `isort`       | `ruff`          |
| Go         | `gopls`         | `goimports`, `gofumpt` | `golangci-lint` |
| Bash       | —               | `shfmt`                | `shellcheck`    |
| Lua        | `lua_ls`        | `stylua`               | —               |
| Terraform  | `terraformls`   | `terraform fmt`        | `tflint`        |
| Ansible    | —               | —                      | `ansible-lint`  |
| Markdown   | `marksman`      | —                      | —                   |

> **Note:** This config avoids npm-dependent tools. Bash, Ansible, and Markdown
> rely on treesitter for syntax highlighting plus dedicated linters/formatters
> instead of LSP servers. If you have Node.js installed, you can swap in
> `pyright`, `bashls`, `ansiblels`, `prettier`, and `markdownlint` as alternatives.

All LSP servers, formatters, and linters are installed automatically via [Mason](https://github.com/mason-org/mason.nvim).

## Requirements

- Neovim >= **0.11** (stable)
- `git`, `make`, `gcc`, `unzip`
- [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`)
- [fd](https://github.com/sharkdp/fd) (optional, improves Telescope file finding)
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) (optional, for parser compilation)
- A [Nerd Font](https://www.nerdfonts.com/) installed and selected in your terminal
- A clipboard tool (`xclip`, `xsel`, or `wl-clipboard`)
- Language runtimes for the languages you use (`python3`, `go`, `node`, etc.)

### Quick install (Ubuntu/Debian)

```sh
sudo apt update
sudo apt install make gcc ripgrep fd-find unzip git xclip
```

## Installation

This config is managed with [GNU Stow](https://www.gnu.org/software/stow/). From the dotfiles root:

```sh
cd ~/.dotfiles
stow nvim
```

This symlinks `~/.config/nvim` to the config in this repo.

Then start Neovim:

```sh
nvim
```

Lazy.nvim will automatically install all plugins on first launch. Mason will install LSP servers, formatters, and linters. Use `:Lazy` and `:Mason` to check status.

## Keyboard Shortcuts

See [SHORTCUTS.md](SHORTCUTS.md) for a full reference of all keybindings.

Key highlights:

| Shortcut             | Description                      |
|----------------------|----------------------------------|
| `<Space>`            | Leader key                       |
| `Ctrl+E`             | Toggle file explorer             |
| `<leader>sf`         | Search files                     |
| `<leader>sg`         | Live grep                        |
| `<leader>f`          | Format buffer                    |
| `grd`                | Go to definition                 |
| `grr`                | Go to references                 |
| `grn`                | Rename symbol                    |
| `<leader><leader>`   | Switch between open buffers      |

## Structure

```
nvim/.config/nvim/
├── init.lua                 # Main configuration (single-file, everything in one place)
├── lua/
│   └── kickstart/
│       └── health.lua       # :checkhealth support
├── SHORTCUTS.md             # Full keyboard shortcut reference
└── README.md                # This file
```

## Health Check

Run `:checkhealth` inside Neovim to verify your system is set up correctly.