#!/usr/bin/env bash

# Get source directory
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)

# Create necessary config directories
mkdir $HOME
mkdir $HOME/.config
mkdir $HOME/.config/bspwm
mkdir $HOME/.config/sxhkd

# Link files
ln -s $DIR/luakit $HOME/.config/luakit
ln -s $DIR/shell/zshrc $HOME/.zshrc
ln -s $DIR/shell/bashrc $HOME/.bashrc
ln -s $DIR/vim/vimrc $HOME/.vimrc
ln -s $DIR/xorg/xinitrc $HOME/.xinitrc
ln -s $DIR/xorg/Xresources $HOME/.Xresources
ln -s $DIR/wm/bspwmrc $HOME/.config/bspwm/bspwmrc
ln -s $DIR/wm/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
