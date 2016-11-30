#!/usr/bin/env bash

# This script will seriously nuke your home directory. You should really read
# each of the scripts that will be executed in those process.

# the path to the dotfiles directory/repository
export DOTFILES_PATH="$HOME/.dotfiles"

# this variable controls whether or not we have a separate dir we like to
# actually use as home instead of $HOME in order to avoid dotfiles clutter
# for all user-facing purposes, we try to use this as the home directory while
# programs will still use $HOME (which in my case is usually /home/username/usr)
export NICE_HOME=$(realpath "$HOME/..")

# this prevents different bar modules from being loaded you should probably
# avoid setting them here and set them in "$HOME/.bashrc_env"
export BLACKLISTED_BAR_MODULES=""

# in some cases (mainly OS provisioning) we clone repositories or download code
# for later use
# as I'm writing this, I realize I should almost certainly be using /tmp and am more
# than a little bit ashamed
# TODO: use /tmp ?
export REPOSITORY_PATH="$NICE_HOME/code/open-source"

# the width of the border around the bspwm windows
export BORDER_WIDTH=0

# the gap between bspwm windows
export WINDOW_GAP=5

# load our font variables
source "$DOTFILES_PATH/scripts/get_x_fonts.sh"

# load our color info
source "$DOTFILES_PATH/scripts/get_color.sh"

# load our bar variables
source "$DOTFILES_PATH/env/wm/extras/bar/variables.bash"

# when we kill bspwm we can export the state to this file
export BSPWM_STATE_FILE="$DOTFILES_PATH/bspwm_state.json.tmp"

# this lets our window gap account for the border width
# if this is enabled, it is usually so that I can reduce border width on my
# desktops with a single chrome window on them so that I can click that tabs at
# the top quickly
# I really need to migrate browsers
# export WINDOW_GAP=$(expr $WINDOW_GAP - $BORDER_WIDTH)

# load per-device bashrc_env if it exists
if [ -a "$HOME/.bashrc_env" ]; then
  . "$HOME/.bashrc_env"
fi
