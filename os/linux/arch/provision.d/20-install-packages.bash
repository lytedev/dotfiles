#!/usr/bin/env bash

# if grep -E -q '^\[multilib\]$' /etc/pacman.conf; then
# 	echo "Multilib Repository Already Enabled!"
# else
# 	echo "Enabling Multilib Repository (with sudo)..."
# 	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
# fi

paru -Sy --needed --noconfirm \
	watchexec `# Filesystem Event Wacher` \
	fwupd `# Firmware Update Manager` \
	ncdu `# Disk Usage Analyzer` \
	efibootmgr efivar `# UEFI Boot CLI Stuff` \
	weechat `# IRC Client` \
	aria2 `# Downloads Manager` \
	wezterm `# Terminal` \
	tailscale `# VPN` \
	ripgrep `# Code Search Utilities` \
	git-delta `# Better Diff Viewer` \
	fd `# File Search` \
	exa `# Better ls` \
	sd `# Better sed` \
	bat `# Better Cat` \
	skim `# Fuzzy Finder` \
	htop bottom `# Process Management and System Resources Monitoring` \
	openssh mosh `# Remote Access` \
	openssl `# Crypto` \
	asdf-vm `# Version Manager` \
	oath-toolkit `# TOTP Utility` \
	pass pass-otp `# Password Management` \
	sc-im `# Spreadsheets` \
	cloc `# For counting lines of code` \
	pigz `# Multicore Compression Utility` \
	hexyl `# CLI Hex Viewer` \
	rsync rclone `# File Transfer` \
	helix `# Text Editors` \
	unzip `# Simple Unzipping` \
	zellij `# Terminal Multiplexer` \
	nmap traceroute iputils `# Networking Utilities` \
	kitty-terminfo `# Better Terminal Emulator` \
	curl wget xh `# HTTP Utilities` \
	w3m `# Web Browser` \
	jq gron `# JSON Utilities` \
	age sops `# Simple Secrets Managements` \
	inotify-tools `# Filesystem Watching` \
	fish `# Shell` \
	time `# GNU Time` \
	fortune-mod fortune-mod-archlinux `# Fortune` \
	sysstat `# System Statistics` \
	reflector `# Simple Pacman Mirror Management` \
	gnu-netcat socat websocat `# Socket Utilities` \
	nnn `# CLI File Manager` \
	avahi	nss-mdns `# mDNS and Network Discovery Utilities` \
	man-db man-pages `# Come On, Man!`
