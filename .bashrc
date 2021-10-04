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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

RESET_COLOR="\[\033[00m\]"
DEB_CHROOT="${debian_chroot:+($debian_chroot)}"

USER_PROMPT='\u@\h'
USER_COLOR="\[\033[01;32m\]"

#PART_PROMPT="(\$(df --output=source . | grep -v 'Filesystem')):"
CD_PROMPT="\w"
CD_COLOR="\[\033[01;34m\]"

GIT_COLOR="\[\033[33m\]"
GIT_BRANCH="\$(git symbolic-ref --short HEAD 2>/dev/null)"
#GIT_COMMIT="\[\$(git rev-parse --short=5 HEAD 2>/dev/null)\]"

GIT_PROMPT="$GIT_BRANCH"
if [ "$GIT_COMMIT" ]; then
GIT_PROMPT="$GIT_PROMPT#$GIT_COMMIT"
fi
BASH_PROMPT="$RESET_COLOR\$ "

if [ "$color_prompt" = yes ]; then
    PS1="$DEB_CHROOT$USER_COLOR$USER_PROMPT$RESET_COLOR:$CD_COLOR$CD_PROMPT $GIT_COLOR$GIT_PROMPT"
#    PS1="$DEB_CHROOT$RESET_COLOR$PART_PROMPT$CD_COLOR$CD_PROMPT $GIT_COLOR$GIT_PROMPT"
else
     PS1="$DEB_CHROOT$USER_PROMPT:$CD_PROMPT:$GIT_PROMPT"
#     \[\e]0;: \a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$

fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;$DEB_CHROOT$USER_PROMPT: $CD_PROMPT $GIT_PROMPT\a\]$PS1"
    ;;
*)
    ;;
esac

PS1="$PS1$BASH_PROMPT"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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

[ -f ~/.config/sarpnt_port ] && ~/.config/sarpnt_port
export PATH=$PATH:~/.local/bin:~/Documents/dev/cpp/cc65/bin:~/.local/share/lutris/runners/retroarch

export NVM_DIR="$HOME/.local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export RVM_DIR="$HOME/.local/share/rvm"
#export PATH="$PATH:$RVM_DIR/bin"
[[ -s "$RVM_DIR/scripts/rvm" ]] && source "$RVM_DIR/scripts/rvm"

# added by travis gem
[ ! -s ~/.travis/travis.sh ] || source ~/.travis/travis.sh


#docker
export DOCKER_HOST=tcp://127.0.0.1:2375


source /etc/profile.d/devkit-env.sh
alias linux-config='/usr/bin/git --git-dir=/home/tumble/linux-config --work-tree=/home/tumble'
alias cls=clear
alias python=python3
alias "rm=rm -i"
alias "mv=mv -i"
alias "cp=cp -i"
alias "ls=ls -al"


export "EDITOR=codium --wait"
export "VISUAL=codium --wait"
