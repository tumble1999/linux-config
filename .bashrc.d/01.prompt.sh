#!/usr/bin/env bash

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
#CD_PROMPT="\w"
CD_PROMPT="\W"
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
