#!/usr/bin/env bash

# This script will seriously nuke your home directory. You should really read
# each of the scripts that will be executed in those process.

export DOTFILES_PATH="$HOME/.dotfiles"
export REPOSITORY_PATH="$HOME/Documents/open-source"
export BORDER_WIDTH=1
export WINDOW_GAP=5
export BAR_PID_FILE="$DOTFILES_PATH/wm_bar.pid"

source "$DOTFILES_PATH/scripts/get_x_fonts.sh"
source "$DOTFILES_PATH/scripts/get_color.sh"

export BAR_ON_XINIT=0
export BAR_FIFO="$DOTFILES_PATH/wm_bar_fifo.lock"
export BAR_LOG="$DOTFILES_PATH/wm_bar.log"
export BAR_TOP=0
export BAR_HEIGHT=20
export BAR_BORDER_WIDTH=1
export BAR_FONT_FAMILY="$PRIMARY_FONT_FAMILY_WITH_SIZE"
export BAR_UNDERLINE=1
# export BAR_MARGIN=$WINDOW_GAP
export BAR_MARGIN=700
export BAR_WID="wmpanel"

export TOP_BAR_PADDING=0
export BOTTOM_BAR_PADDING=0

if [[ $BAR_TOP -eq 0 ]]; then
	export BOTTOM_BAR_PADDING=$BAR_HEIGHT
else
	export TOP_BAR_PADDING=$BAR_HEIGHT
fi

export WINDOW_GAP=$(expr $WINDOW_GAP - $BORDER_WIDTH)

# load per-device bashrc_env if it exists
if [ -a "$HOME/.bashrc_env" ]; then
  . "$HOME/.bashrc_env"
fi

# various paths that are used in the dotfiles
BAR_PATH="$DOTFILES_PATH/env/wm/extras/bar"

