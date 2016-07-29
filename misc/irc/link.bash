#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

rm -rf "$HOME/.weechat/weechat.conf"
mkdir -p "$HOME/.weechat/"
ln -s "$DOTFILES_PATH/misc/irc/weechat.conf" "$HOME/.weechat/weechat.conf"

