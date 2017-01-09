#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

rm -rf "$HOME/.config/kak"
ln -s "$DOTFILES_PATH/editor/kakoune" "$HOME/.config/kak"
