#!/usr/bin/env bash

echo "Installing paru as $(whoami)"
REPOSITORY_PATH="/tmp/provisioning"
sudo pacman -S --needed --noconfirm git base-devel
mkdir -p "$REPOSITORY_PATH"
rm -rf "$REPOSITORY_PATH/paru"
git clone https://aur.archlinux.org/paru-bin.git "$REPOSITORY_PATH/paru"
cd "$REPOSITORY_PATH/paru" || exit 1
makepkg --noconfirm -si
paru -S --noconfirm paru-bin
rm -rf "$REPOSITORY_PATH/paru"
