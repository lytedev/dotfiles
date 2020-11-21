#!/usr/bin/env bash

REPOSITORY_PATH="/tmp/provisioning"
sudo pacman -S --needed git base-devel
mkdir -p "$REPOSITORY_PATH"
rm -rf "$REPOSITORY_PATH/yay"
git clone https://aur.archlinux.org/yay.git "$REPOSITORY_PATH/yay"
cd "$REPOSITORY_PATH/yay"
makepkg -si
yay -S yay
rm -rf "$REPOSITORY_PATH/yay"
