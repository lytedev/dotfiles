#!/usr/bin/env bash

# This script will seriously nuke your home directory. You should really read
# each of the scripts that will be executed in those process.

DOTFILES_PATH=$HOME/.dotfiles
REPOSITORY_PATH=$HOME/Documents/Repositories
WINDOW_GAP=20
BORDER_WIDTH=2

BAR_FIFO="$DOTFILES_PATH/wm_bar_fifo.lock"
BAR_TOP=1
BAR_MARGIN=$WINDOW_GAP
BAR_HEIGHT=30

# load per-device bashrc_env if it exists
if [ -a "$HOME/.bashrc_env" ]; then
  . "$HOME/.bashrc_env"
fi

