#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

sudo pacman -S curl openssl perl expac yajl --noconfirm

# receive cower's gpg key
gpg --recv-keys 1EB2638FF56C0C53

mkdir -p "$REPOSITORY_PATH"

git clone https://aur.archlinux.org/cower.git "$REPOSITORY_PATH/cower"
git clone https://aur.archlinux.org/pacaur.git "$REPOSITORY_PATH/pacaur"

cd "$REPOSITORY_PATH/cower"
makepkg -i --noconfirm
cd -

cd "$REPOSITORY_PATH/pacaur"
makepkg -i --noconfirm
cd -

pacaur -S cower pacaur --noconfirm --noedit

