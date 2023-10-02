# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cls=clear
alias linux-config="/usr/bin/git --git-dir=${HOME}/.local/dotfiles.git --work-tree=${HOME}"
PS1='[\u@\h \W]\$ '





# Python
export PATH="$PATH:/home/tumble/.local/bin:/home/tumble/.pyenv/bin"
# Ruby
eval "$(rbenv init - bash)"
