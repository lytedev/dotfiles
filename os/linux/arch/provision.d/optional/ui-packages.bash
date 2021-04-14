#!/usr/bin/env bash

if grep -E -q '^\[multilib\]$' /etc/pacman.conf; then
	echo "Multilib Repository Already Enabled!"
else
	echo "Enabling Multilib Repository (with sudo)..."
	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
fi

# TODO: some of these may be laptop-only?

# TODO: switch to Nautilus?

yay -Sy \
	xf86-input-libinput \
	libinput libinput-gestures `# Trackpad Control` \
	bluez bluez-libs bluez-utils bluez-tools `# Bluetooth` \
	arc-gtk-theme `# GTK Theme` \
	elementary-icon-theme `# GUI File Explorer Icons` \
	thunar thunar-volman gvfs `# GUI File Explorer + Volume Management/Auto-Mount Disks)` \
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
	postgresql pgcli `# RDBMS` \
	cloc `# For counting lines of code` \
	noto-fonts noto-fonts-emoji `# Emoji` \
	discord `# Voice Chat` \
	steam steamcmd lutris `# Games` \
	gnome-shell `# Guh-nome Guh-shell` \
	vlc `# Video Viewer` \
	zathura zathura-pdf-mupdf `# Document Viewer` \
 	glu mesa wxgtk2 libpng `# Graphical Libs` \
	gammastep `# Redshift for Wayland` \
	dmenu `# Application Launcher` \
	python python-pip `# Python 3 Language` \
	firefox-developer-edition `# Default Web Browser` \
	alsa-utils `# Audio Utilities` \
	alsa-plugins `# Plugins for ALSA` \
	pulseaudio pavucontrol pulsemixer `# Audio Backend and Controls` \
	playerctl `# Media Keys Controls` \
	feh `# Image Viewer & Wallpaper Manager` \
	wlroots sway `# Wayland Compositor` \
	swaylock swayidle `# Auto-Locking for Sway` \
	kanshi `# Monitor Management for Sway` \
	wofi `# Sway app launcher` \
	waybar mako `# Sway Bar & Notifications` \
	slurp grim wl-clipboard `# Sway Screen Selection & Clipping` \
	pipewire pipewire-pulse pipewire-media-session `# Pipewire` \
	xdg-desktop-portal xdg-desktop-portal-wlr `# Screensharing` \
	obs-studio-wayland obs-xdg-portal `# OBS` \
	ttf-iosevka `# Primary Fonts` \
	ttf-font-awesome `# Icon Font` \
	ripcord `# Discord and Slack Client`
