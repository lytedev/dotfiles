#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

rm -rf "$HOME/.mutt"
ln -s "$DOTFILES_PATH/email/mutt/config" "$HOME/.mutt"
