#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

rm "$HOME/.xinitrc"
rm "$HOME/.Xresources"
ln -s "$HOME/.dotfiles/x/xinitrc" "$HOME/.xinitrc"
ln -s "$HOME/.dotfiles/x/xresources" "$HOME/.Xresources"

xrdb "$HOME/.Xresources" >/dev/null 2>&1

if [ -f "$HOME/.Xresources.colors" ]; then
  xrdb -merge "$HOME/.Xresources.colors" >/dev/null 2>&1
fi

if [ -f "$HOME/.Xresources.env" ]; then
  xrdb -merge "$HOME/.Xresources.env" >/dev/null 2>&1
fi

