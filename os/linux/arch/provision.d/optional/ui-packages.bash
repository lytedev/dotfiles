#!/usr/bin/env bash

# if grep -E -q '^\[multilib\]$' /etc/pacman.conf; then
# 	echo "Multilib Repository Already Enabled!"
# else
# 	echo "Enabling Multilib Repository (with sudo)..."
# 	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
# fi

# TODO: some of these may be laptop-only?
# TODO: switch from Thunar to Nautilus?

paru -Sy --needed \
	xf86-input-libinput \
	libinput libinput-gestures `# Trackpad Control` \
	bluez bluez-libs bluez-utils bluez-tools `# Bluetooth` \
	arc-gtk-theme `# GTK Theme` \
	elementary-icon-theme `# GUI File Explorer Icons` \
	thunar thunar-volman gvfs `# GUI File Explorer + Volume Management/Auto-Mount Disks)` \
	ttf-iosevka-lyte `# My font` \
	ttf-iosevka-lyte-nerd-font `# My font` \
	ttf-opensans `# Fonts` \
	avr-libc avr-gcc dfu-programmer dfu-util `# Keyboard Programming Utilities` \
	gimp inkscape krita `# Image/Vector Editing Applications` \
	audacity `# Audio Editing Application` \
	deluge deluge-gtk `# GUI Torrent Client` \
	gdm `# Display Manager of choice` \
	pigz `# Multi-core gzipping` \
	samba `# Sharing Files with other (Windows) PCs` \
	gvfs-smb `# Auto-Detect Samba Shares?` \
	cmake `# Cross-Platform Make` \
	elixir nodejs erlang rustup `# Langs` \
	php `# PHP Language` \
	nginx `# Web Server` \
	python python-pip `# Python 3 Language` \
	ctags `# Tags` \
	postgresql pgcli `# RDBMS` \
	sc-im `# Spreadsheets` \
	cloc `# For counting lines of code` \
	noto-fonts noto-fonts-emoji `# Emoji` \
	discord `# Personal & Voice Chat` \
	slack-desktop `# Work Chat` \
	steam steamcmd lutris `# Games` \
	gnome-shell `# Guh-nome Guh-shell` \
	vlc `# Video Viewer` \
	zathura zathura-pdf-mupdf `# Document Viewer` \
 	glu mesa wxgtk2 libpng `# Graphical Libs` \
	gammastep `# Redshift for Wayland` \
	dmenu `# Application Launcher` \
	firefox `# Default Web Browser` \
	hunspell-en_US `# Firefox Spell Checking` \
	passff-host `# Pass integration in Firefox` \
	kitty-git `# Terinal Emulator` \
	alsa-utils `# Audio Utilities` \
	alsa-plugins `# Plugins for ALSA` \
	pavucontrol pulsemixer `# Audio Backend and Controls` \
	playerctl `# Media Keys Controls` \
	feh `# Image Viewer & Wallpaper Manager` \
	wlroots sway swaybg `# Wayland Compositor` \
	swaylock swayidle `# Auto-Locking for Sway` \
	kanshi `# Monitor Management for Sway` \
	wofi `# Sway app launcher` \
	waybar mako `# Sway Bar & Notifications` \
	slurp grim wl-clipboard `# Sway Screen Selection & Clipping` \
	pipewire pipewire-pulse wireplumber `# Pipewire` \
	xdg-desktop-portal xdg-desktop-portal-wlr `# Screensharing` \
	obs-studio `# OBS` \
	ttf-font-awesome `# Icon Font` \
	ripcord `# Discord and Slack Client`
