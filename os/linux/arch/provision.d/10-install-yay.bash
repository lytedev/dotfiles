#!/usr/bin/env bash

echo "Installing yay as $(whoami)"
REPOSITORY_PATH="/tmp/provisioning"
sudo pacman -S --needed --noconfirm git base-devel
mkdir -p "$REPOSITORY_PATH"
rm -rf "$REPOSITORY_PATH/yay"
git clone https://aur.archlinux.org/yay-bin.git "$REPOSITORY_PATH/yay"
cd "$REPOSITORY_PATH/yay" || exit 1
makepkg --noconfirm -si
yay -S --noconfirm yay-bin
rm -rf "$REPOSITORY_PATH/yay"
