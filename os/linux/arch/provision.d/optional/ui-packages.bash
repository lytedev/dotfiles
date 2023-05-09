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
	xf86-input-libinput libinput libinput-gestures `# Trackpad Settings and Customizations` \
	bluez bluez-libs bluez-utils bluez-tools `# Bluetooth` \
	arc-gtk-theme elementary-icon-theme `# GUI Theme Stuff` \
	thunar thunar-volman gvfs `# File Manager` \
	ttf-iosevka-lyte ttf-nerd-fonts-symbols-mono ttf-opensans `# Fonts` \
	avr-libc avr-gcc dfu-programmer dfu-util `# MCU Programming Utilities` \
	gimp inkscape krita `# Image/Vector Editing Applications` \
	audacity `# Audio Editing Application` \
	cmake `# Cross-Platform Make` \
	caddy `# Web Server` \
	noto-fonts noto-fonts-emoji `# Emoji` \
	vlc `# Video Viewer` \
	zathura zathura-pdf-mupdf `# Document Viewer` \
	gammastep `# Screen Color Temp Adjuster` \
	firefox `# Default Web Browser` \
	hunspell-en_US `# Firefox Spell Checking` \
	passff-host `# Pass integration in Firefox` \
	kitty-git `# Terminal Emulator` \
	wezterm `# Terminal Emulator` \
	pavucontrol pulsemixer `# Pulseaudio Controls` \
	playerctl `# Media Keys Controls` \
	feh `# Image Viewer and Wallpaper Manager` \
	hyprland hyprpaper `# Wayland Compositor` \
	polkit-kde-agent `# Privilege Escalation` \
	swaylock swayidle `# Locking and Idling` \
	waybar mako `# Bar and Notifications` \
	slurp grim wl-clipboard `# Screenshots and Clipboard Utilities` \
	pipewire pipewire-pulse wireplumber `# Audio System` \
	xdg-desktop-portal xdg-desktop-portal-wlr `# Screensharing` \
	obs-studio `# Audio and Video Streaming` \
