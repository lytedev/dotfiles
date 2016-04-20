#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source $DIR/variables.bash

mkdir -p "$HOME/.tmux/layouts"

rm -f "$HOME/.bashrc"
rm -f "$HOME/.bash_profile"
rm -f "$HOME/.tmux.conf"
rm -f "$HOME/.tmux/layouts/dev.tmux"
rm -f "$HOME/.inputrc"
ln -s "$DOTFILES_PATH/sh/bashrc" "$HOME/.bashrc"
ln -s "$DOTFILES_PATH/sh/bash_profile" "$HOME/.bash_profile"
ln -s "$DOTFILES_PATH/sh/tmux.conf" "$HOME/.tmux.conf"
ln -s "$DOTFILES_PATH/sh/layout_dev.tmux" "$HOME/.tmux/layouts/dev.tmux"
ln -s "$DOTFILES_PATH/sh/inputrc" "$HOME/.inputrc"

sed -i "/export DOTFILES_PATH/c export DOTFILES_PATH=\"$DIR\"" "$HOME/.bashrc"

echo "You should re-source ~/.bashrc ;)"

