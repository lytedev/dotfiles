#!/usr/bin/env bash

# This script is for setting up a base arch machine
# It assumes a "base base-devel" pacstrap. 

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)

# This fixes a weird gnupg/dirmngr bug.
sudo mkdir -p /root/.gnupg/
sudo touch /root/.gnupg/dirmngr_ldapservers.conf

# Allow auto-signing of GPG keys
sed -i "s/#keyserver-options auto-key-retrieve/keyserver-options auto-key-retrieve/" "$HOME/.gnupg/gpg.conf"

# Sign infinality keys
sudo pacman-key -r 962DDE58
sudo pacman-key -f 962DDE58
sudo pacman-key --lsign 962DDE58

# Sign cower keys
gpg --recv-key 1EB2638FF56C0C53

# Add infinality repos
sudo sh -c 'sed -i -e "/\[infinality-bundle\]/,+6d" /etc/pacman.conf'
sudo sh -c 'echo -e "[infinality-bundle]\nServer = http://bohoomil.com/repo/\$arch\n\n[infinality-bundle-fonts]\nServer = http://bohoomil.com/repo/fonts\n" >> /etc/pacman.conf'

# Update
sudo pacman -Syyu --noconfirm

# Add our packages
sudo pacman -Sf --noconfirm git zsh python luakit xorg-server xorg-server-utils xorg-xinit xorg-xrandr vim curl openssh openssl sudo python2 tmux terminus-font ttf-inconsolata unzip libxcb xcb-util xcb-util-keysyms xcb-util-wm gcc make rxvt-unicode yajl expac xsel unclutter xautolock slock infinality-bundle htop

# Create necessary config directories
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/bspwm"
mkdir -p "$HOME/.config/sxhkd"

# Xorg and WM Configs
rm -f "$HOME/.xinitrc"
rm -f "$HOME/.Xresources"
rm -f "$HOME/.config/bspwm/bspwmrc"
rm -f "$HOME/.config/sxhkd/sxhkdrc"
ln -s "$DIR/wm/xorg/xinitrc" "$HOME/.xinitrc"
ln -s "$DIR/wm/xorg/Xresources" "$HOME/.Xresources"
ln -s "$DIR/wm/bspwmrc" "$HOME/.config/bspwm/bspwmrc"
ln -s "$DIR/wm/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"

# Make AUR repo folder
mkdir -p "$HOME/code/aur"
cd "$HOME/code/aur"

# Get pacaur for managing AUR packages
curl -O https://aur.archlinux.org/packages/co/cower/cower.tar.gz
curl -O https://aur.archlinux.org/packages/pa/pacaur/pacaur.tar.gz

tar -xzf cower.tar.gz
tar -xzf pacaur.tar.gz

cd cower
makepkg -i --noconfirm

cd ../pacaur
makepkg -i --noconfirm 

cd ..
rm -f *.tar.gz

# AUR packages
pacaur -S --noconfirm --noedit ttf-opensans kpcli perl-clipboard dmenu-xft-height lemonbar-xft-git neovim-git

# Get our window manager code and build
mkdir -p "$HOME/code/repos"
cd "$HOME/code/repos"

git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git

cd bspwm
make
sudo make install

cd ../sxhkd
make
sudo make install

