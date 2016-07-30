#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source $DIR/variables.bash

sudo pacman -S mplayer --noconfirm

git clone https://github.com/malcolmstill/thunner.git "$REPOSITORY_PATH/thunner"

sudo pip2 install gmusicapi

sudo ln -s "$REPOSITORY_PATH/thunner/thunner" /usr/bin/thunner

