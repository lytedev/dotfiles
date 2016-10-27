#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
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
	openssh \
	openssl \
	--noconfirm

pacaur -S \
	gtk-theme-arc \
	weechat \
	ruby \
	tcl \
	mtpfs \
	libmtp \
	gvfs-mtp \
	pass \
	qutebrowser \
	bash-completion \
	avr-libc avr-gcc dfu-programmer dfu-util \
	reptyr \
	fzf \
	urxvt-perls-git \
	mutt procmail msmtp \
	ncmpcpp mpd \
	rsync \
	samba \
	thunar-shares-plugin \
	nmap \
	pulseaudio-ctl \
	pavucontrol \
	alsa-plugins \
	--noconfirm --noedit

# sudo ln -s /usr/bin/google-chrome-unstable /usr/bin/chrome

