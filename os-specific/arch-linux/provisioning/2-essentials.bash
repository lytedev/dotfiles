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
	--noconfirm

pacaur -S \
	urxvt-perls-git \
	samba \
	pulseaudio-ctl \
	alsa-plugins \
  unclutter-xfixes-git gtk-theme-arc gtk-engine-murrine xorg-server-devel \
  bspwm-git sxhkd-git xdo-git \
	--noconfirm --noedit

# sudo ln -s /usr/bin/google-chrome-unstable /usr/bin/chrome

