#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

sudo pacman -S cmake vim unzip python2 python2-pip python python-pip xsel xclip --noconfirm

sudo pip3 install neovim
sudo pip2 install neovim

git clone https://github.com/neovim/neovim "$REPOSITORY_PATH/neovim"

cd "$REPOSITORY_PATH/neovim"
make
sudo make install
cd -

