#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source $DIR/variables.bash

mkdir -p "$HOME/.tmux/layouts"

MODULE_PATH="$DOTFILES_PATH/env/sh"

rm -f "$HOME/.bashrc"
rm -f "$HOME/.bash_profile"
rm -f "$HOME/.tmux.conf"
rm -f "$HOME/.tmux/layouts/dev.tmux"
rm -f "$HOME/.inputrc"
ln -s "$MODULE_PATH/bashrc" "$HOME/.bashrc"
ln -s "$MODULE_PATH/bash_profile" "$HOME/.bash_profile"
ln -s "$MODULE_PATH/tmux.conf" "$HOME/.tmux.conf"
ln -s "$MODULE_PATH/layout_dev.tmux" "$HOME/.tmux/layouts/dev.tmux"
ln -s "$MODULE_PATH/inputrc" "$HOME/.inputrc"

sed -i "/export DOTFILES_PATH/c export DOTFILES_PATH=\"$DIR\"" "$HOME/.bashrc"

echo "You should re-source ~/.bashrc ;)"
