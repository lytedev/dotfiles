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
	brightnessctl `# Brightness CLI` \
	bluez bluez-libs bluez-utils bluez-tools `# Bluetooth` \
	catppuccin-gtk-theme-mocha elementary-icon-theme `# GUI Theme` \
	thunar thunar-volman gvfs `# GUI File Manager` \
	ttf-iosevka-lyte ttf-nerd-fonts-symbols-mono ttf-opensans `# Fonts` \
	noto-fonts noto-fonts-emoji `# Emoji Fonts` \
	avr-libc avr-gcc dfu-programmer dfu-util `# MCU Programming Utilities` \
	gimp inkscape krita `# Image and Vector Editing Applications` \
	caddy `# Web Server` \
	vlc `# Video Viewer` \
	zathura zathura-pdf-mupdf `# Document Viewer` \
	gammastep `# Screen Color Temp Adjuster` \
	firefox `# Web Browser` \
	hunspell-en_US `# Firefox Spell Checking` \
	passff-host `# pass integration in Firefox` \
	kitty `# Terminal Emulator` \
	wezterm `# Terminal Emulator` \
	pulsemixer pavucontrol pamixer libpulse `# Pulseaudio Controls` \
	playerctl `# Media Keys Controls` \
	feh `# Image Viewer` \
	sway swaybg `# Window Manager and Wallpaper` \
	wofi `# Launcher` \
	polkit polkit-kde-agent `# Privilege Escalation Prompts` \
	swaylock swayidle `# Locking and Idling` \
	mako `# Notification Daemon` \
	slurp grim wl-clipboard `# Screenshots and Clipboard Utilities` \
	pipewire pipewire-pulse wireplumber `# Audio` \
	xdg-desktop-portal xdg-desktop-portal-wlr `# Screensharing` \
	obs-studio `# Live Streaming` \
	eww-wayland `# Bar & Widgets`