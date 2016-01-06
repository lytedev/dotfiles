#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

rm "$HOME/.xinitrc"
rm "$HOME/.Xresources"
ln -s "$HOME/.dotfiles/x/xinitrc" "$HOME/.xinitrc"
ln -s "$HOME/.dotfiles/x/xresources" "$HOME/.Xresources"

