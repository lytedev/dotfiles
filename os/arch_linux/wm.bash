#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

sudo pacman -S xcb-util xcb-util-keysyms xcb-util-wm xorg-xrandr xdotool feh --noconfirm
pacaur -S bspwm-git sxhkd-git xdo-git --noconfirm --noedit

