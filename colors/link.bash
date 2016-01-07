#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

rm -f ~/.Xresources.colors
rm -f "$DOTFILES_PATH/vim/config/colors/current.vim"
ln -s "$DOTFILES_PATH/colors/xresources" "$HOME/.Xresources.colors"
ln -s "$DOTFILES_PATH/colors/vim" "$DOTFILES_PATH/vim/config/colors/current.vim"

source "$DOTFILES_PATH/x/xloadresources"

