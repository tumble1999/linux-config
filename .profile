# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if ! pgrep -x ssh-agent -u $(id -u) >/dev/null; then
    # This sets SSH_AUTH_SOCK and SSH_AGENT_PID variables
    eval "$(ssh-agent -s)"
    export SSH_AUTH_SOCK SSH_AGENT_PID
    cat >"$XDG_RUNTIME_DIR/ssh-agent-env" <<-__EOF__
	export SSH_AUTH_SOCK=$SSH_AUTH_SOCK
	export SSH_AGENT_PID=$SSH_AGENT_PID
	__EOF__
else
    if [ -s "$XDG_RUNTIME_DIR/ssh-agent-env" ]; then
        . $XDG_RUNTIME_DIR/ssh-agent-env
    fi
fi

ssh-add .ssh/id_rsa 
