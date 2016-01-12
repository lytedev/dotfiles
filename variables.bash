#!/usr/bin/env bash

# This script will seriously nuke your home directory. You should really read
# each of the scripts that will be executed in those process.

DOTFILES_PATH="$HOME/.dotfiles"
REPOSITORY_PATH="$HOME/Documents/Repositories"
WINDOW_GAP=20
BORDER_WIDTH=2

source "$DOTFILES_PATH/scripts/get_x_fonts.sh"
source "$DOTFILES_PATH/scripts/get_color.sh"

BAR_ON_XINIT=0
BAR_FIFO="$DOTFILES_PATH/wm_bar_fifo.lock"
BAR_TOP=0
BAR_MARGIN=$WINDOW_GAP
BAR_HEIGHT=28
BAR_BORDER_WIDTH=2
BAR_FONT_FAMILY="$PRIMARY_FONT_FAMILY_WITH_SIZE"
BAR_UNDERLINE=1

# load per-device bashrc_env if it exists
if [ -a "$HOME/.bashrc_env" ]; then
  . "$HOME/.bashrc_env"
fi

