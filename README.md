# linux-config

Setup
```
cd ~
git clone --bare git@github.com:tumble1999/linux-config.git .local/dotfiles.git
git --git-dir=.local/dotfiles.git --work-tree=. checkout master
source .bashrc
linux-config submodule update --init --recursive
```
