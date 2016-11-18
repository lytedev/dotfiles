#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

sudo rm -f "/usr/local/bin/melee"
sudo ln -s "$DOTFILES_PATH/scripts/melee.bash" "/usr/local/bin/melee"

