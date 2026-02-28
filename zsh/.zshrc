# ~/.zshrc — Zsh configuration ported from ~/.bashrc

# Only run in interactive sessions
[[ -o interactive ]] || return

# ─── History ──────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt APPEND_HISTORY         # append instead of overwrite
setopt HIST_IGNORE_DUPS       # don't store duplicate lines
setopt HIST_IGNORE_SPACE      # ignore commands starting with a space
setopt HIST_REDUCE_BLANKS     # tidy up whitespace
setopt SHARE_HISTORY          # share history across sessions

# ─── Shell options ────────────────────────────────────────────────────
setopt AUTO_CD                # cd by typing a directory name
setopt INTERACTIVE_COMMENTS   # allow comments in interactive shells
setopt GLOB_DOTS              # include dotfiles in glob results
setopt EXTENDED_GLOB          # zsh equivalent of bash globstar / extglob

# ─── Completion ───────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select                  # arrow-key menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case-insensitive

# ─── Environment variables ───────────────────────────────────────────
export EDITOR='nvim'

# PATH — prepend custom directories
typeset -U PATH   # automatically deduplicate
export PATH="${HOME}/.cargo/bin:/opt/nvim-linux-x86_64/bin:${HOME}/.local/bin:${PATH}"

# ─── Colour support for ls / grep ────────────────────────────────────
if [[ -x /usr/bin/dircolors ]]; then
    if [[ -r ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ─── Aliases ─────────────────────────────────────────────────────────
# Editor
alias vim='nvim'
alias vi='nvim'

# Listing (eza)
alias ll='eza -hla --group-directories-first'
alias lls='eza -hla --group-directories-first --total-size'
alias la='ls -A'
alias l='ls -CF'

# Archives
alias untar='tar zxfv'

# Git
alias gp='git pull'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gb='git rebase'

# Desktop notification for long-running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1 | sed -e "s/^\s*//;s/[;&|]\s*alert$//")"'

# ─── Lesspipe ────────────────────────────────────────────────────────
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# ─── Cargo environment ───────────────────────────────────────────────
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ─── Tool initialisations ────────────────────────────────────────────
# Starship prompt
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# Zoxide (smart cd)
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

# AWS CLI completion
if (( $+commands[aws] )); then
    autoload -Uz bashcompinit && bashcompinit
    complete -C '/usr/local/bin/aws_completer' aws
fi
