#!/usr/bin/env bash

# Get source directory
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)

# Link files
rm -r $HOME/.config/luakit
rm -r $HOME/.zshrc
rm -r $HOME/.bashrc
rm -r $HOME/.vimrc
rm -r $HOME/.tmux.conf
rm -r $HOME/.irssi
rm -r $HOME/.muttrc
rm -r $HOME/.nvimrc
rm -r $HOME/.config/bar
ln -s $DIR/apps/luakit $HOME/.config/luakit
ln -s $DIR/shell/zshrc $HOME/.zshrc
ln -s $DIR/shell/bashrc $HOME/.bashrc
ln -s $DIR/apps/vim/vimrc $HOME/.vimrc
ln -s $DIR/apps/nvim/nvimrc $HOME/.nvimrc
ln -s $DIR/shell/tmux.conf $HOME/.tmux.conf
ln -s $DIR/apps/irssi $HOME/.irssi
ln -s $DIR/apps/mutt/muttrc $HOME/.muttrc
ln -s $DIR/wm/bar $HOME/.config/bar

