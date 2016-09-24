#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

sudo pacman -S tmux --noconfirm

mkdir -p "$HOME/.tmux/plugins/"
rm -rf "$HOME/.tmux/plugins/tpm"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux source "$DOTFILES_PATH/sh/tmux.conf"

