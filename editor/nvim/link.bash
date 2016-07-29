#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

rm -rf "$HOME/.config/nvim"
ln -s "$DOTFILES_PATH/editor/nvim/config" "$HOME/.config/nvim"

nvim +PlugInstal +qall

