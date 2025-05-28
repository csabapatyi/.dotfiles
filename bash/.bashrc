# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
. "$HOME/.cargo/env"


# Custom Setings
alias vim="nvim"
alias vi="nvim"
alias ll="eza -hla --group-directories-first"
alias lls="eza -hla --group-directories-first --total-size"
eval "$(starship init bash)"
eval "$(zoxide init bash)"

export PATH="/opt/nvim-linux-x86_64/bin:${HOME}/.local/bin:${PATH}"a
export EDITOR='nvim'
complete -C '/usr/local/bin/aws_completer' aws


# git aliases
alias gp="git pull"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gb="git rebase"

# SSH Agent Setup - Share agent across terminals
SSH_ENV="${HOME}/.ssh/agent-environment"

# Function to start the agent
start_ssh_agent() {
    echo "Initializing new SSH agent..."
    # Start ssh-agent, redirecting output to our environment file
    ssh-agent -s > "${SSH_ENV}"
    # Set permissions for the environment file
    chmod 0600 "${SSH_ENV}"
    # Source the environment file into the current shell
    . "${SSH_ENV}" > /dev/null # Source it to get SSH_AGENT_PID etc.

    if [ -S "$SSH_AUTH_SOCK" ]; then
        echo "SSH agent started (PID: $SSH_AGENT_PID)."
        echo "Adding SSH identities from ${HOME}/.ssh/ ..."
        find "${HOME}/.ssh/" -maxdepth 1 -type f \
            ! -name '*.pub' \
            ! -name 'known_hosts' \
            ! -name 'authorized_keys' \
            ! -name 'config' \
            ! -name 'agent-environment' \
            -print0 | while IFS= read -r -d $'\0' key_file; do
            ssh-add "${key_file}" < /dev/null 2>/dev/null
        done
        # ssh-add -l # Optionally list keys
    else
        echo "Failed to start ssh-agent and source environment."
        # Clean up the potentially incomplete env file if agent failed to start properly
        rm -f "${SSH_ENV}"
    fi
}

# Check if SSH_AUTH_SOCK is set and the socket file exists and agent is responsive
if [ -S "$SSH_AUTH_SOCK" ] && ssh-add -l > /dev/null 2>&1; then
    echo "SSH agent already configured and responsive for this shell (PID: $SSH_AGENT_PID)."
else
    # If SSH_AUTH_SOCK is not set or agent not responsive, try to load from file
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null # Source the environment variables
        # After sourcing, check again if the agent is responsive
        if ! ssh-add -l > /dev/null 2>&1; then
            echo "Found agent environment file, but agent not responsive. Starting new one."
            start_ssh_agent
        else
            echo "Connected to existing SSH agent (PID: $SSH_AGENT_PID, Socket: $SSH_AUTH_SOCK)."
        fi
    else
        # No environment file, so start a new agent
        start_ssh_agent
    fi
fi

# Optional: Clean up the agent environment file on shell exit
# This is tricky because you only want the *last* shell using the agent to kill it.
# A more robust solution for agent lifetime management is tools like 'keychain'
# or systemd user services if you need the agent to persist even after all shells close.
# For simplicity, this script doesn't automatically kill the agent or remove SSH_ENV on exit.
# You can manually kill it with: eval $(cat ~/.ssh/agent-environment | grep SSH_AGENT_PID | sed 's/SSH_AGENT_PID=\([0-9]*\); export SSH_AGENT_PID;/ssh-agent -k; echo Agent \1 killed/')
# Or more simply if you sourced it: ssh-agent -k (this will use the env vars)
# And then: rm ~/.ssh/agent-environment

