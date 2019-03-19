#!/usr/bin/env bash

pacaur --needed -S \
	arc-gtk-theme-git `# GTK Theme` \
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
	deluge `# GUI Torrent Client` \
	lightdm lightdm-gtk-greeter `# Nice User Login` \
	polybar-git `# Bar` \
	php `# PHP Language` \
	nginx `# Web Server` \
	postgresql pgcli `# RDBMS` \
	urxvt-perls-git urxvt-resize-font-git `# rxvt-unicode scripts` \
	neofetch `# swag` \
	cloc `# For counting lines of code` \
	ttf-noto-fonts-simple ttf-noto-fonts-ib noto-fonts-emoji `# Emoji` \
	siji-git gohufont artwiz-fonts phallus-fonts-git `# Bitmap Fonts` \
	autorandr `# Monitor Helper` \
	keybase keybase-gui kbfs `# Keybase Applications` \
	--noconfirm --noedit
