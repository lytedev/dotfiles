#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source $DIR/variables.bash

sudo pacman -S \
	tree \
	rofi \
	slock \
	the_silver_searcher \
	thunar thunar-volman gvfs \
	audacity \
	luakit \
	gimp \
	alsa-utils \
	wpa_actiond \
	ifplugd \
	htop \
	--noconfirm

pacaur -S \
	gtk-theme-arc \
	google-chrome-dev \
	weechat \
	ruby \
	tcl \
	mtpfs \
	libmtp \
	gvfs-mtp \
	pass \
	bash-completion \
	avr-libc avr-gcc dfu-programmer dfu-util \
	reptyr \
	--noconfirm --noedit

sudo ln -s /usr/bin/google-chrome-unstable /usr/bin/chrome

