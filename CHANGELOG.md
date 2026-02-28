# Changelog

All notable changes to this dotfiles repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added
- **Fish shell configuration** (`fish/.config/fish/config.fish`) — new primary shell config
  - Ported all aliases, environment variables, and tool initialisations from bash
  - Starship prompt and zoxide integration
  - Cargo environment support
  - dircolors support
- **Zsh configuration** (`zsh/.zshrc`) — future-proof alternative shell config
  - Full port of bash config with zsh-native idioms
  - Enhanced completion system with arrow-key menus and case-insensitive matching
  - `SHARE_HISTORY` for cross-session history sharing
  - `bashcompinit` for AWS CLI completion compatibility
- **Neovim configuration rewrite** — complete overhaul based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
  - Gruvbox theme (dark, hard contrast) to match tmux
  - 2-space tab/indent settings globally
  - Case-insensitive search with smart-case
  - Neo-tree file explorer on `Ctrl+E`
  - Language support (LSP, formatting, linting, treesitter):
    - Python: `basedpyright`, `black`, `isort`, `ruff`
    - Go: `gopls`, `goimports`, `gofumpt`, `golangci-lint`
    - Bash: `shfmt`, `shellcheck`
    - Lua: `lua_ls`, `stylua`
    - Terraform: `terraformls`, `terraform fmt`, `tflint`
    - Ansible: `ansible-lint`
    - Markdown: `marksman`
  - blink.cmp autocompletion with LuaSnip and friendly-snippets
  - conform.nvim for format-on-save
  - nvim-lint for async linting
  - DAP debugger with Go support (delve)
  - Gitsigns with full hunk navigation, staging, and blame keymaps
  - Which-key for keybind discoverability
  - Telescope fuzzy finder for files, grep, LSP symbols, and more
  - Mini.nvim modules (ai, surround, statusline)
  - Todo-comments, autopairs, indent-blankline
  - `SHORTCUTS.md` — full keyboard shortcut reference
  - Updated `README.md` with setup instructions and language support table

### Changed
- Neovim config now avoids npm-dependent tools — all Mason-installed tools work without Node.js
- Neovim health check updated to require Neovim >= 0.11
- Consolidated all neovim plugin config into single `init.lua` (removed modular plugin files)

### Removed
- `lua/kickstart/plugins/` directory (autopairs, debug, gitsigns, indent_line, lint, neo-tree — all inlined into `init.lua`)
- `lua/custom/plugins/` directory (was empty placeholder)
- tokyonight theme (replaced by gruvbox)
- nvim-cmp (replaced by blink.cmp)
- vim-sleuth (replaced by guess-indent.nvim)

## [0.2.0] - 2025-01-15

### Changed
- Removed SSH agent settings from bashrc due to issues on other machines
- Reverted tmux prefix key from `Ctrl+a` back to default `Ctrl+b` to keep keybinds as standard as possible

## [0.1.0] - 2024-12-01

### Added
- Initial dotfiles repository with GNU Stow structure
- **Bash** configuration (`.bashrc`)
  - Custom aliases (`vim`/`vi` → `nvim`, `ll`/`lls` via `eza`, git aliases)
  - Starship prompt and zoxide integration
  - Cargo environment and PATH setup
  - AWS CLI completion
- **Neovim** configuration based on kickstart.nvim
  - LSP, Telescope, Treesitter, and core plugins
- **Tmux** configuration
  - Gruvbox theme via `z3z1ma/tmux-gruvbox`
  - Vi-like pane navigation and copy-paste
  - Mouse support, 256-color terminal
  - TPM plugin manager
- **Midnight Commander** (`mc`) configuration