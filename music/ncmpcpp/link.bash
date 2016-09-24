#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

rm -rf "$HOME/.ncmpcpp"
ln -s "$DOTFILES_PATH/music/ncmpcpp" "$HOME/.ncmpcpp"

