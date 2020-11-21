#!/usr/bin/env bash

if egrep -q '^\[multilib\]$' /etc/pacman.conf; then
	echo "Multilib Repository Already Enabled!"
else
	echo "Enabling Multilib Repository (with sudo)..."
	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
fi

yay -Sy \
	xf86-input-libinput \
	bluez bluez-libs bluez-utils bluez-tools `# Bluetooth` \
	pigz `# Multi-core gzipping` \
	iw `# WiFi Power Saving` \
	arc-gtk-theme `# GTK Theme` \
	elementary-icon-theme `# GUI File Explorer Icons` \
	thunar thunar-volman gvfs `# GUI File Explorer + Volume Management/Auto-Mount Disks)` \
	samba `# Sharing Files with other (Windows) PCs` \
	gvfs-smb `# Auto-Detect Samba Shares` \
	ttf-opensans ttf-dejavu ttf-liberation `# Fonts` \
	avr-libc avr-gcc dfu-programmer dfu-util `# Keyboard Programming Utilities` \
	xorg-xbacklight `# Xorg Backlight Control` \
	gimp inkscape krita `# Image/Vector Editing Applications` \
	audacity `# Audio Editing Application` \
	cmake `# Cross-Platform Make` \
	accountsservice `# Mainly for User Avatars with Display Manager` \
	gdm `# Display Manager of choice` \
	deluge deluge-gtk cairo python-cairo `# GUI Torrent Client` \
	elixir nodejs erlang rustup \
	php `# PHP Language` \
	nginx `# Web Server` \
	postgresql pgcli `# RDBMS` \
	neofetch `# swag` \
	cloc `# For counting lines of code` \
	noto-fonts noto-fonts-emoji `# Emoji` \
	docker `# Containers` \
	discord `# Chat` \
	steam steamcmd lutris `# Games` \
	gnome-shell `# Guh-nome Guh-shell` \
	vlc `# Video Viewer` \
	ncdu `# Disk Usage Analyzer` \
	zathura zathura-pdf-mupdf `# Document Viewer` \
	libinput libinput-gestures `# Trackpad Control` \
	efibootmgr efivar `# UEFI Boot CLI Stuff` \
 	glu mesa wxgtk2 libpng `# Various` \
	gammastep `# Redshift for Wayland` \
	weechat `# IRC Client` \
	aria2 `# Downloads Manager` \
	tree `# Handy Filesystem Viewing Utility` \
	dmenu `# Application Launcher` \
	ripgrep `# Code Search Utilities` \
	fd `# File Search` \
	sd `# Easy Find/Replace` \
	fzf `# Fuzzy File Finder` \
	htop `# Process Management and System Resources Monitoring` \
	openssh mosh `# Remote Access` \
	openssl `# Crypto` \
	asdf-vm `# Runtime Version Manager` \
	python python-pip `# Python 3 Language` \
	pass `# Password Management` \
	firefox-developer-edition `# Default Web Browser` \
	rsync `# File Transfer` \
	alsa-utils `# Audio Utilities` \
	alsa-plugins `# Plugins for ALSA` \
	pulseaudio pavucontrol pulsemixer `# Audio Backend and Controls` \
	neovim `# Text Editors` \
	sc-im `# Spreadsheets` \
	unzip `# Simple Unzipping` \
	tmux `# Terminal Multiplexer` \
	kitty `# Almost Better Terminal Emulator` \
	feh `# Image Viewer & Wallpaper Manager` \
	wlroots-git sway-git `# Wayland Compositor` \
	swaylock-git swayidle-git `# Auto-Locking for Sway` \
	kanshi-git `# Monitor Management for Sway` \
	waybar-git mako-git `# Sway Bar & Notifications` \
	slurp grim wl-clipboard `# Sway Screen Selection & Clipping` \
	pipewire pipewire-pulse libpipewire02 `# Pipewire` \
	xdg-desktop-portal xdg-desktop-portal-wlr `# Screensharing` \
	obs-studio-wayland obs-xdg-portal `# OBS` \
	ttf-iosevka `# Primary Fonts` \
	ttf-font-awesome `# Icon Font` \
	curl `# HTTP Utility` \
	w3m `# Viewing Images in Terminals` \
	jq `# CLI for Interacting with JSON` \
	ranger `# CLI File Manager` \
	httpie `# httpie and neovim dependencies` \
	docker docker-compose `# Yummy containers` \
	inotify-tools `# Watching` \
	fish `# Shell` \
	time `# GNU time` \
	fortune-mod fortune-mod-archlinux `# Fortune` \
	diff-so-fancy `# Fancy Diffs` \
	oath-toolkit `# One-Time Passwords` \
	sysstat `# System Statistics` \
	ripcord `# Discord and Slack Client`
