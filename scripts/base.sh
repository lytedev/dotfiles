#!/usr/bin/env bash

# This script is for setting up a base arch machine
# It assumes a "base base-devel" pacstrap. 

# This fixes a weird gnupg/dirmngr bug.
mkdir -p /root/.gnupg/
touch /root/.gnupg/dirmngr_ldapservers.conf

pacman-key -r 962DDE58
pacman-key -f 962DDE58
pacman-key --lsign 962DDE58

echo -e "[infinality-bundle]\nServer = http://bohoomil.com/repo/\$arch\n\n[infinality-bundle-fonts]\nServer = http://bohoomil.com/repo/fonts\n" >> /etc/pacman.conf

pacman -Syyu --noconfirm

pacman -S --noconfirm git zsh python luakit xorg-server xorg-server-utils xorg-xinit xorg-xrandr vim curl openssh openssl sudo python2 tmux terminus-font ttf-inconsolata unzip libxcb xcb-util xcb-util-keysyms xcb-util-wm gcc make rxvt-unicode yajl expac infinality-bundle

