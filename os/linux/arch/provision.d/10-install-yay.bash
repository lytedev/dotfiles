#!/usr/bin/env bash

echo $USER
REPOSITORY_PATH="/tmp/provisioning"
sudo pacman -S --needed --noconfirm git base-devel
mkdir -p "$REPOSITORY_PATH"
rm -rf "$REPOSITORY_PATH/yay"
git clone https://aur.archlinux.org/yay.git "$REPOSITORY_PATH/yay"
cd "$REPOSITORY_PATH/yay"
makepkg --noconfirm -si
yay -S --noconfirm yay
rm -rf "$REPOSITORY_PATH/yay"
