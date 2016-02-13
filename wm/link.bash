#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

rm -f "$HOME/.config/bspwm/bspwmrc"
rm -f "$HOME/.config/sxhkd/sxhkdrc"
ln -s "$DOTFILES_PATH/wm/bspwmrc" "$HOME/.config/bspwm/bspwmrc"
ln -s "$DOTFILES_PATH/wm/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"
