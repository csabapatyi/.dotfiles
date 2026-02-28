# ~/.config/fish/config.fish
# Fish shell configuration — ported from ~/.bashrc

# Only run in interactive sessions
if not status is-interactive
    return
end

# ─── History ──────────────────────────────────────────────────────────
# Fish handles history well out of the box (no duplicates when using
# `history merge`, and it already ignores leading-space commands).
# We just set the size to match the old bash values.
set -g fish_history_size 2000

# ─── Environment variables ───────────────────────────────────────────
set -gx EDITOR nvim

# PATH — prepend custom directories (fish deduplicates automatically)
fish_add_path -gP "$HOME/.cargo/bin"
fish_add_path -gP /opt/nvim-linux-x86_64/bin
fish_add_path -gP "$HOME/.local/bin"

# ─── Colour support for ls / grep ────────────────────────────────────
# dircolors — load user colours if available
if test -x /usr/bin/dircolors
    if test -r ~/.dircolors
        eval (dircolors -c ~/.dircolors)
    else
        eval (dircolors -c)
    end
end

alias grep  'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

# ─── Aliases ─────────────────────────────────────────────────────────
# Editor
alias vim nvim
alias vi  nvim

# Listing (eza)
alias ll  'eza -hla --group-directories-first'
alias lls 'eza -hla --group-directories-first --total-size'
alias la  'ls -A'
alias l   'ls -CF'

# Archives
alias untar 'tar zxfv'

# Git
alias gp  'git pull'
alias gcm 'git commit -m'
alias gca 'git commit --amend'
alias gb  'git rebase'

# Desktop notification for long-running commands
alias alert 'notify-send --urgency=low -i "terminal" "Command finished"'

# ─── Cargo environment ───────────────────────────────────────────────
if test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end

# ─── Tool initialisations ────────────────────────────────────────────
# Starship prompt
if type -q starship
    starship init fish | source
end

# Zoxide (smart cd)
if type -q zoxide
    zoxide init fish | source
end

# AWS CLI completion
if type -q aws
    complete -c aws -f -a '(begin; set -lx COMP_SHELL fish; set -lx COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end
