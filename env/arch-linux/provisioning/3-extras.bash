#!/usr/bin/env bash

if egrep -q '^\[multilib\]$' /etc/pacman.conf; then
	echo "Multilib Repository Already Enabled!"
else
	echo "Enabling Multilib Repository (with sudo)..."
	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
	yay -Sy
fi

yay -S \
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
	elixir nodejs erlang \
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
	gammastep `# Redshift for Wayland`

curl -L -o "$HOME/.emoji.txt" https://lyte.dev/uploads/emoji.txt
