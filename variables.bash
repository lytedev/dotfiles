#!/usr/bin/env bash

# This script will seriously nuke your home directory. You should really read each of the scripts that will be executed in those process.

DOTFILES_PATH=$HOME/.dotfiles
REPOSITORY_PATH=$HOME/Documents/Repositories
WINDOW_GAP=20
BORDER_WIDTH=2

# load per-device bashrc_env if it exists
if [ -a "$HOME/.bashrc_env" ]; then
  . "$HOME/.bashrc_env"
fi

