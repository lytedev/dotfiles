#!/usr/bin/env bash

# This script will seriously nuke your home directory. You should really read
# each of the scripts that will be executed in those process.

export DOTFILES_PATH="$HOME/.dotfiles"
export REPOSITORY_PATH="$HOME/Documents/Repositories"
export WINDOW_GAP=20
export BORDER_WIDTH=2

source "$DOTFILES_PATH/scripts/get_x_fonts.sh"
source "$DOTFILES_PATH/scripts/get_color.sh"

export BAR_ON_XINIT=0
export BAR_FIFO="$DOTFILES_PATH/wm_bar_fifo.lock"
export BAR_TOP=0
export BAR_MARGIN=$WINDOW_GAP
export BAR_HEIGHT=28
export BAR_BORDER_WIDTH=2
export BAR_FONT_FAMILY="$PRIMARY_FONT_FAMILY_WITH_SIZE"
export BAR_UNDERLINE=1

# load per-device bashrc_env if it exists
if [ -a "$HOME/.bashrc_env" ]; then
  . "$HOME/.bashrc_env"
fi
