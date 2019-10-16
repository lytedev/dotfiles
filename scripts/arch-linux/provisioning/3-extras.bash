#!/usr/bin/env bash

if egrep -q '^\[multilib\]$' /etc/pacman.conf; then
	echo "Multilib Repository Already Enabled!"
else
	echo "Enabling Multilib Repository (with sudo)..."
	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
	pacaur -Syy
fi

pacaur --needed -S \
	bluez bluz-libs bluez-utils bluez-tools \
	pigz `# Multi-core gzipping` \
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
	accountsservice `# Mainly for User Avatars with LightDM` \
	deluge cairo python-cairo `# GUI Torrent Client` \
	lightdm lightdm-gtk-greeter `# Nice User Login` \
	polybar-git `# Bar` \
	php `# PHP Language` \
	nginx `# Web Server` \
	postgresql pgcli `# RDBMS` \
	urxvt-perls-git urxvt-resize-font-git `# rxvt-unicode scripts` \
	neofetch `# swag` \
	cloc `# For counting lines of code` \
	ttf-noto-fonts-simple ttf-noto-fonts-ib noto-fonts-emoji `# Emoji` \
	siji-git gohufont artwiz-fonts `# Bitmap Fonts` \
	autorandr `# Monitor Helper` \
	docker `# Containers` \
	keybase keybase-gui kbfs `# Keybase Applications` \
	discord `# Chat` \
	steam steamcmd lutris `# Games` \
	gnome-shell `# Guh-nome Guh-shell` \
	redshift `# Save Your Eyes` \
	vlc `# Video Viewer` \
	ncdu `# Disk Usage Analyzer` \
	--noconfirm --noedit
