#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

MODULE_PATH="$DOTFILES_PATH/env/wm"

mkdir -p "$HOME/.config/bspwm"
mkdir -p "$HOME/.config/sxhkd"

rm -f "$HOME/.config/bspwm/bspwmrc"
rm -f "$HOME/.config/sxhkd/sxhkdrc"
ln -s "$MODULE_PATH/bspwmrc" "$HOME/.config/bspwm/bspwmrc"
ln -s "$MODULE_PATH/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"

