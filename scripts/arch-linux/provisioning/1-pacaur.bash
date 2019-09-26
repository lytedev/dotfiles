#!/usr/bin/env bash

# TODO: this script is out of date!

# installs pacaur on a fresh arch install

# install the dependencies
sudo pacman -S git curl openssl perl expac yajl meson gmock gtest jq --noconfirm

# setup a temporary place to install the packages from
REPOSITORY_PATH="/tmp/provisioning"
mkdir -p "$REPOSITORY_PATH"

# clone the repositories
rm -rf "$REPOSITORY_PATH/auracle-git"
rm -rf "$REPOSITORY_PATH/pacaur"
git clone https://aur.archlinux.org/auracle-git.git "$REPOSITORY_PATH/auracle-git"
git clone https://aur.archlinux.org/pacaur.git "$REPOSITORY_PATH/pacaur"

# build and install auracle
cd "$REPOSITORY_PATH/auracle-git"
makepkg -i --noconfirm
cd -

# build and install pacaur
cd "$REPOSITORY_PATH/pacaur"
makepkg -i --noconfirm
cd -

# cleanup
rm -rf "$REPOSITORY_PATH/auracle-git"
rm -rf "$REPOSITORY_PATH/pacaur"

# once installed, let the package manager manage itself and its dependencies
pacaur -S auracle-git pacaur --noconfirm --noedit

