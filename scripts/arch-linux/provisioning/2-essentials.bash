#!/usr/bin/env bash

pacaur -S \
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
	terminus-font ttf-monaco \
	ttf-freefont \
	ttf-font-awesome \
	curl \
	--noconfirm --noedit

sudo pip3 install neovim
sudo pip2 install neovim

sudo ln -s /usr/bin/google-chrome-unstable /usr/bin/chrome

mkdir -p "$HOME/.fonts/OTF"
curl -L -o "$HOME/.fonts/OTF/monaco_powerline_nerd_font.otf" https://github.com/taohex/font/raw/master/Monaco%20for%20Powerline%20Nerd%20Font%20Complete.otf
fc-cache -vf
