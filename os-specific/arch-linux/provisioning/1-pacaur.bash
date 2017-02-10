#!/usr/bin/env bash

# install the dependencies
sudo pacman -S git curl openssl perl expac yajl --noconfirm

# receive cower's gpg key
gpg --recv-keys 1EB2638FF56C0C53

# setup a temporary place to install the packages from
REPOSITORY_PATH="/tmp/provisioning"
mkdir -p "$REPOSITORY_PATH"

# clone the repositories
git clone https://aur.archlinux.org/cower.git "$REPOSITORY_PATH/cower"
git clone https://aur.archlinux.org/pacaur.git "$REPOSITORY_PATH/pacaur"

# build and install cower
cd "$REPOSITORY_PATH/cower"
makepkg -i --noconfirm --noedit
cd -

# build and install pacaur
cd "$REPOSITORY_PATH/pacaur"
makepkg -i --noconfirm --noedit
cd -

# once installed, let the package manager manage itself and its dependencies
pacaur -S cower pacaur --noconfirm --noedit

