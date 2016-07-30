#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

rm -f "$HOME/.gitconfig"
ln -s "$DOTFILES_PATH/misc/git/gitconfig" "$HOME/.gitconfig"

