#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source $DIR/variables.bash

rm "$HOME/.bashrc"
rm "$HOME/.bash_profile"
rm "$HOME/.tmux.conf"
ln -s "$DOTFILES_PATH/sh/bashrc" "$HOME/.bashrc"
ln -s "$DOTFILES_PATH/sh/bash_profile" "$HOME/.bash_profile"
ln -s "$DOTFILES_PATH/sh/.tmux.conf" "$HOME/.tmux.conf"

sed -i "/export DOTFILES_PATH/c export DOTFILES_PATH=\"$DIR\"" "$HOME/.bashrc"

echo "You should re-source ~/.bashrc ;)"

