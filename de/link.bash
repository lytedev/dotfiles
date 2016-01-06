#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

rm -f "$HOME/.config/bspwm/bspwmrc"
rm -f "$HOME/.config/sxhkd/sxhkdrc"
ln -s "$DOTFILES_PATH/de/bspwmrc" "$HOME/.config/bspwm/bspwmrc"
ln -s "$DOTFILES_PATH/de/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"

