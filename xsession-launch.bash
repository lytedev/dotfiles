#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)
source "$DIR/variables.bash"

export DOTFILES_PATH="$DOTFILES_PATH"

# source "$DOTFILES_PATH/env/x/xloadresources"

bspwm

