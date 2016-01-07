#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

mkdir -p "$REPOSITORY_PATH"

git clone https://github.com/LemonBoy/bar.git "$REPOSITORY_PATH/lemonbar"

cd "$REPOSITORY_PATH/lemonbar"
make
sudo make install
cd -

