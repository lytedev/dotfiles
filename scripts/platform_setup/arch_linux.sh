#!/usr/bin/env bash

# This script is for setting up a base arch machine
# It assumes a "base base-devel" pacstrap.

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)

# This fixes a weird gnupg/dirmngr bug.
sudo mkdir -p /root/.gnupg/
sudo touch /root/.gnupg/dirmngr_ldapservers.conf

# Sign infinality keys
sudo pacman-key -r 962DDE58
sudo pacman-key -f 962DDE58
sudo pacman-key --lsign 962DDE58

# Sign cower keys
gpg --recv-key 1EB2638FF56C0C53

# Allow auto-signing of GPG keys
sed -i "s/#keyserver-options auto-key-retrieve/keyserver-options auto-key-retrieve/" "$HOME/.gnupg/gpg.conf"

# Sign cower keys again to refresh
gpg --recv-key 1EB2638FF56C0C53

# Add infinality repos
sudo sh -c 'sed -i -e "/\[infinality-bundle\]/,+6d" /etc/pacman.conf'
sudo sh -c 'echo -e "[infinality-bundle]\nServer = http://bohoomil.com/repo/\$arch\n\n[infinality-bundle-fonts]\nServer = http://bohoomil.com/repo/fonts\n" >> /etc/pacman.conf'

# Update
sudo pacman -Syyu --noconfirm

# Add our packages
sudo pacman -S --noconfirm git zsh python luakit xorg-server \
    xorg-server-utils xorg-xinit xorg-xrandr vim curl openssh openssl sudo \
    python2 tmux terminus-font ttf-inconsolata unzip libxcb xcb-util \
    xcb-util-keysyms xcb-util-wm gcc make rxvt-unicode yajl expac xsel \
    unclutter xautolock slock htop tree python-pip python2-pip acpi redshift \
    cmake the_silver_searcher inotify-tools sysstat thunar alsa-utils feh \
    imagemagick xf86-video-intel mesa-libgl libva libva-intel-driver mpd \
    ncmpcpp nodejs npm pulseaudio pulseaudio-alsa lib32-libpulse \
    lib32-alsa-plugins irssi xorg-xprop xorg-wininfo bash-completion \
    thunar-volman gvfs gvfs-afc gnu-netcat

# Some manual work required here
# TODO: Flag that lets you force existing package override
sudo pacman -S infinality-bundle

# Create necessary config directories
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/bspwm"
mkdir -p "$HOME/.config/sxhkd"

# Xorg and WM Configs
rm -f "$HOME/.xinitrc"
rm -f "$HOME/.Xresources"
rm -f "$HOME/.config/bspwm/bspwmrc"
rm -f "$HOME/.config/sxhkd/sxhkdrc"
rm -f "$HOME/.config/sxhkd/altsxhkdrc"
ln -s "$DIR/wm/xorg/xinitrc" "$HOME/.xinitrc"
ln -s "$DIR/wm/xorg/Xresources" "$HOME/.Xresources"
ln -s "$DIR/wm/bspwmrc" "$HOME/.config/bspwm/bspwmrc"
ln -s "$DIR/wm/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"
ln -s "$DIR/wm/altsxhkdrc" "$HOME/.config/sxhkd/altsxhkdrc"

# Make AUR repo folder
mkdir -p "$HOME/Documents/Code/aur"
cd "$HOME/Documents/Code/aur"

# Get pacaur (and dependencies) for managing AUR packages
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
pacaur -S ttf-opensans kpcli perl-clipboard dmenu-xft-height lemonbar-xft-git neovim-git mpc powerline-fonts-git twmn-git terminusmod compton stlarch-font-ibx gohufont irssi-script-sasl

# Packages for yubikey
pacaur -S yubikey-personalization-git pcsc-tools pcsclite libusb-compat ccid

# Get our window manager code and build
mkdir -p "$HOME/Documents/Code/repos"
cd "$HOME/Documents/Code/repos"

git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git

cd bspwm
make
sudo make install

cd ../sxhkd
make
sudo make install

# Install Neovim python modules
sudo pip2 install neovim
sudo pip3 install neovim

# TODO: Any other python modules?

# Setup custom keymaps
sudo mkdir -p /usr/local/share/kbd/keymaps

echo "Manual Steps:"
echo "  1. irssi SASL authentication"
echo ""

