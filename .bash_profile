
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$HOME/.local/share/jenv/bin:$PATH"
eval "$(jenv init -)"

export BEATSABER_DIR="/home/tumble/games/steam/steamapps/common/Beat Saber"