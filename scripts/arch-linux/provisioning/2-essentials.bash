#!/usr/bin/env bash

pacaur -S \
	tree `# Handy Filesystem Viewing Utility` \
	rofi `# Application Launcher` \
	the_silver_searcher ripgrep `# Code Search Utilities` \
	alsa-utils `# Audio Utilities` \
	htop `# Process Management and System Resources Monitoring` \
	openssh `# Remote Access` \
	openssl `# Crypto` \
	ruby `# Language` \
	nodejs npm `# Language` \
	python python-pip `# Python 3 Language` \
	python2 python2-pip `# Language` \
	pass `# Password Management` \
	google-chrome-dev `# Default Web Browser` \
	bash-completion `# Handy Scripts for Tab-Completion in Bash` \
	fzf `# Fuzzy File Finder` \
	rsync `# File Transfer` \
	pulseaudio pavucontrol `# Audio Backend and Controls` \
	neovim vim `# Text Editors` \
	unzip `# Handy Utility for ZIP Files` \
	xsel `# Manage X Selection` \
	xclip `# Manage X Clipboards` \
	tmux `# Terminal Multiplexer` \
	rxvt-unicode-pixbuf `# Terminal with PixBuf Patches` \
	xorg-xinit xorg-server xorg-xrdb `# X.org Display Server` \
	xorg-drivers `# Video Drivers for X?` \
	xcb-util xcb-util-keysyms xcb-util-wm xorg-xrandr xdotool feh xorg-xprop `# X Utilties` \
	pulseaudio-ctl `# CLI Utility for Pulseaudio` \
	alsa-plugins `# Plugins for ALSA` \
	unclutter-xfixes-git `# Hides cursor after no use for a time` \
	gtk-engine-murrine xorg-server-devel `# GTK Theme Base and Headers?` \
	bspwm-git sxhkd-git xdo-git `# Window Manager and Tools for its use` \
	terminus-font ttf-monaco `# Primary Fonts` \
	ttf-freefont `# Font` \
	ttf-font-awesome `# Icon Font` \
	curl `# HTTP Utility` \
	w3m w3m-img `# Viewing Images in Terminals` \
	--noconfirm --noedit

# install text editor utilities
sudo pip3 install neovim
sudo pip2 install neovim

# shortcut for browser
sudo ln -s /usr/bin/google-chrome-unstable /usr/bin/chrome

# install patched fonts
mkdir -p "$HOME/.fonts/OTF"
curl -L -o "$HOME/.fonts/OTF/monaco_powerline_nerd_font.otf" https://github.com/taohex/font/raw/master/Monaco%20for%20Powerline%20Nerd%20Font%20Complete.otf
fc-cache -vf

# install rxvt-unicode script for resizing font on-the-fly
mkdir -p "$HOME/.urxvt/ext"
curl -L -o "$HOME/.urxvt/ext/resize-font" https://raw.githubusercontent.com/simmel/urxvt-resize-font/master/resize-font
