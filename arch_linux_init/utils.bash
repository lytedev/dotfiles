#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source $DIR/variables.bash

sudo pacman -S \
  rofi \
  slock \
  the_silver_searcher \
  thunar thunar-volman \
  luakit \
  alsa-utils \
  --noconfirm

pacaur -S \
  gtk-theme-arc \
  firefox-developer \
  google-chrome-dev \
  --noconfirm --noedit

sudo ln -s /usr/bin/firefox-developer /usr/bin/firefox
sudo ln -s /usr/bin/google-chrome-unstable /usr/bin/chrome

