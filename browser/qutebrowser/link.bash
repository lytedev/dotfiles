#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

mkdir -p "$HOME/.config/qutebrowser"

rm -rf "$HOME/.config/qutebrowser"
ln -s "$DOTFILES_PATH/browser/qutebrowser" "$HOME/.config/qutebrowser"

