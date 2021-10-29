# linux-config

Setup
```
cd ~
git clone --bare git@github.com:tumble1999/linux-config.git linux-config
git --git-dir=linux-config --work-tree=. checkout master
source .bashrc
linux-config submodule update --init --recursive
```
