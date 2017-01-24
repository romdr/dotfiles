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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Prompt
PS1="\[$(tput bold)\]\[\033[38;5;34m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]@\h › \[$(tput sgr0)\]\[\033[38;5;69m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\\$ \[$(tput sgr0)\]"

# Enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

# dotfiles first in ls
export LC_COLLATE="C"

# Docker
alias d='docker ps -a --format "table {{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Names}}"'
alias ds='docker ps -a --format "table {{.Status}}\t{{.Names}}"'
alias dw='watch -n 3 "docker ps -a --format \"table {{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Names}}\""'

# ls
alias l='ls -lh'
alias la='ls -lAh'
alias lr='ls -lhR'
alias lar='ls -lAhR'

# tmux
if hash tmux 2>/dev/null; then
  alias tx='tmux'
else
  alias tx='tmux-next'
fi

# quick install of always used programs
. /etc/lsb-release
if [ "$DISTRIB_RELEASE" == "14.04" ]; then
alias installmyfavs='sudo apt-get install -y python-software-properties software-properties-common && \
  sudo apt-add-repository ppa:pi-rho/dev && \
  sudo apt-get update && \
  sudo apt-get install -y htop nano tmux wget && \
  . ~/.bashrc'
fi
if [ "$DISTRIB_RELEASE" == "16.04" ]; then
alias installmyfavs='sudo apt-get install -y htop nano tmux wget && . ~/.bashrc'
fi
