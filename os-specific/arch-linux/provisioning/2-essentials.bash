#!/usr/bin/env bash

sudo pacman -S \
	tree \
	rofi \
	slock \
	the_silver_searcher \
	alsa-utils \
	htop \
	openssh \
	openssl \
	ruby \
	python python-pip \
	python2 python2-pip \
	pass \
	qutebrowser \
	bash-completion \
	fzf \
	rsync \
	pavucontrol \
	neovim \
	vim \
	unzip \
	xsel \
	xclip \
	tmux \
	rxvt-unicode \
	xorg-xinit xorg-server xorg-xrdb \
	xcb-util xcb-util-keysyms xcb-util-wm xorg-xrandr xdotool feh \
	irssi \
	--noconfirm

pacaur -S \
	urxvt-perls-git \
	samba \
	pulseaudio-ctl \
	alsa-plugins \
	unclutter-xfixes-git gtk-engine-murrine xorg-server-devel \
	bspwm-git sxhkd-git xdo-git \
	siji-git terminus-font ttf-monaco gohufont artwiz-fonts phallus-fonts-git \
	--noconfirm --noedit

sudo pip3 install neovim
sudo pip2 install neovim

# sudo ln -s /usr/bin/google-chrome-unstable /usr/bin/chrome

