#!/usr/bin/env bash

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export RVM_DIR="$HOME/.local/share/rvm"
#export PATH="$PATH:$RVM_DIR/bin"
[[ -s "$RVM_DIR/scripts/rvm" ]] && source "$RVM_DIR/scripts/rvm"