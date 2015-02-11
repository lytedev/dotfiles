#!/usr/bin/env bash

# Get source directory
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)

# Link files
rm -r $HOME/.config/luakit
rm -r $HOME/.zshrc
rm -r $HOME/.bashrc
rm -r $HOME/.vimrc
rm -r $HOME/.tmux.conf
ln -s $DIR/luakit $HOME/.config/luakit
ln -s $DIR/shell/zshrc $HOME/.zshrc
ln -s $DIR/shell/bashrc $HOME/.bashrc
ln -s $DIR/vim/vimrc $HOME/.vimrc
ln -s $DIR/shell/tmux.conf $HOME/.tmux.conf

