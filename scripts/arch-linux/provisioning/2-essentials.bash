#!/usr/bin/env bash

sudo pacaur -S \
	tree \
	rofi \
	the_silver_searcher ripgrep \
	alsa-utils \
	htop \
	openssh \
	openssl \
	ruby \
	nodejs npm \
	python python-pip \
	python2 python2-pip \
	pass \
	google-chrome-dev \
	bash-completion \
	fzf \
	rsync \
	pulseaudio pavucontrol \
	neovim vim \
	unzip \
	xsel \
	xclip \
	tmux \
	rxvt-unicode \
	xorg-xinit xorg-server xorg-xrdb \
	xcb-util xcb-util-keysyms xcb-util-wm xorg-xrandr xdotool feh xorg-xprop \
	irssi \
	pulseaudio-ctl \
	alsa-plugins \
	unclutter-xfixes-git gtk-engine-murrine xorg-server-devel \
	bspwm-git sxhkd-git xdo-git \
	siji-git terminus-font ttf-monaco gohufont artwiz-fonts phallus-fonts-git \
	--noconfirm --noedit

sudo pip3 install neovim
sudo pip2 install neovim

sudo ln -s /usr/bin/google-chrome-unstable /usr/bin/chrome

