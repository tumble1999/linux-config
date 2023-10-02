# .bash_profile

[[ -s "/etc/profile" ]] && source "/etc/profile" # Load the system .profile

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

