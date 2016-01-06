#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

sudo pacman -S xcb-util xcb-util-keysyms xcb-util-wm --noconfirm

mkdir -p "$REPOSITORY_PATH"

git clone https://github.com/baskerville/bspwm.git "$REPOSITORY_PATH/bspwm"
git clone https://github.com/baskerville/sxhkd.git "$REPOSITORY_PATH/sxhkd"

cd "$REPOSITORY_PATH/bspwm"
make
sudo make install
cd -

cd "$REPOSITORY_PATH/sxhkd"
make
sudo make install
cd -

