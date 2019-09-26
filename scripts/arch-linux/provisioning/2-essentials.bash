#!/usr/bin/env bash

pacaur --needed -S \
	neomutt `# Email Client` \
	weechat `# IRC Client` \
	aria2 `# Downloads Manager` \
	tree `# Handy Filesystem Viewing Utility` \
	rofi `# Application Launcher` \
	ripgrep `# Code Search Utilities` \
	fd `# File Search` \
	fzf `# Fuzzy File Finder` \
	htop `# Process Management and System Resources Monitoring` \
	openssh mosh `# Remote Access` \
	openssl `# Crypto` \
	elixir `# Elixir Language` \
	nodejs npm yarn `# JavaScript Runtime` \
	python python-pip `# Python 3 Language` \
	pass `# Password Management` \
	firefox-developer-edition `# Default Web Browser` \
	rsync `# File Transfer` \
	alsa-utils `# Audio Utilities` \
	alsa-plugins `# Plugins for ALSA` \
	pulseaudio pavucontrol `# Audio Backend and Controls` \
	pulseaudio-ctl `# CLI Utility for Pulseaudio` \
	neovim vim `# Text Editors` \
	unzip `# Simple Unzipping` \
	xclip xsel `# X Selection & Clipboard Management` \
	autocutsel `# Clipboard Helper` \
	tmux `# Terminal Multiplexer` \
	rxvt-unicode-pixbuf `# Terminal with PixBuf Patches` \
	kitty `# Almost Better Terminal Emulator` \
	xorg-xinit xorg-server xorg-xrdb `# X Display Server` \
	xorg-drivers `# Video Drivers for X` \
	xcb-util xcb-util-keysyms xcb-util-wm xorg-xrandr xdotool xorg-xprop `# X Utilties` \
	feh `# Image Viewer & Wallpaper Manager` \
	unclutter-xfixes-git `# Hides cursor after no use for a time` \
	gtk-engine-murrine xorg-server-devel `# GTK Theme Base and Headers?` \
	bspwm-git sxhkd-git xdo-git `# Window Manager and Tools for its use` \
	wlroots-git sway-git `# Wayland Compositor` \
	terminus-font ttf-iosevka-type ttf-iosevka-term `# Primary Fonts` \
	ttf-font-awesome `# Icon Font` \
	curl `# HTTP Utility` \
	w3m `# Viewing Images in Terminals` \
	jq `# CLI for Interacting with JSON` \
	ranger `# CLI File Manager` \
	bash-completion `# Handy Scripts for Tab-Completion in Bash` \
	python-neovim python-jedi python-mistune python-psutil python-setproctitle httpie `# httpie and neovim dependencies` \
	--noconfirm --noedit

# install rxvt-unicode script for resizing font on-the-fly
mkdir -p "$HOME/.urxvt/ext"
curl -L -o "$HOME/.urxvt/ext/resize-font" https://raw.githubusercontent.com/lytedev/urxvt-resize-font/master/resize-font
