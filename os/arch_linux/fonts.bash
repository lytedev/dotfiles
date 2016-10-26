#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source $DIR/variables.bash

# sign keys for infinality
sudo pacman-key -r 962DDE58
sudo pacman-key -f 962DDE58
sudo pacman-key --lsign 962DDE58
gpg --recv-keys AE6866C7962DDE58

sudo sh -c 'sed -i -e "/\[infinality-bundle\]/,+6d" /etc/pacman.conf'
sudo sh -c 'echo -e "[infinality-bundle]\nServer = http://bohoomil.com/repo/\$arch\n\n[infinality-bundle-fonts]\nServer = http://bohoomil.com/repo/fonts\n" >> /etc/pacman.conf'

sudo pacman -Syy --noconfirm
sudo pacman -S infinality-bundle terminus-font

pacaur -S ttf-monaco gohufont artwiz-fonts phallus-fonts-git --noconfirm --noedit
sudo pacman -S ttf-opensans ttf-dejavu --noconfirm

