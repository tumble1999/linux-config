#!/usr/bin/env bash

# Alias definitions
alias linux-config="/usr/bin/git --git-dir=${HOME}/linux-config --work-tree=${HOME}"
alias "cls=clear"
alias "python=python3"
alias "rm=rm -i"
alias "mv=mv -i"
alias "cp=cp -i"
alias "edit=${EDITOR}"
alias "ls=ls -al"
alias shutdown='openrc-shutdown -p'
alias reboot='openrc-shutdown -r'
alias superkill="killall -s SIGKILL"
alias ssh="TERM=xterm-256color ssh"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
 	export LESS='-R --use-color -Dd+r$Du+b'
 	alias ip='ip -color=auto'
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
	alias diff='diff --color=auto'
	alias ls='ls -al --color=auto'
	alias pacman='pacman --color=auto'
	alias yay='yay --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
