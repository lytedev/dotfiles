#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

rm -rf "$HOME/.mpdconf"
ln -s "$DOTFILES_PATH/music/mpdconf" "$HOME/.mpdconf"

