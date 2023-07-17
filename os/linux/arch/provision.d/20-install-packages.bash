#!/usr/bin/env bash

# if grep -E -q '^\[multilib\]$' /etc/pacman.conf; then
# 	echo "Multilib Repository Already Enabled!"
# else
# 	echo "Enabling Multilib Repository (with sudo)..."
# 	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
# fi

pacman -Sy --needed --noconfirm \
	watchexec `# Filesystem Event Wacher` \
	fwupd `# Firmware Update Manager` \
	efibootmgr efivar `# UEFI Boot CLI Stuff` \
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
	hexyl `# CLI Hex Viewer` \
	rsync rclone `# File Transfer` \
	helix `# Text Editors` \
	unzip `# Simple Unzipping` \
	tmux zellij `# Terminal Multiplexer` \
	dog bind nmap traceroute iputils `# Networking Utilities` \
	curl wget xh `# HTTP Utilities` \
	w3m `# Web Browser` \
	jq gron `# JSON Utilities` \
	age sops `# Simple Secrets Managements` \
	inotify-tools `# Filesystem Watching` \
	fish `# Shell` \
	time `# GNU Time` \
	fortune-mod `# Fortune` \
	sysstat `# System Statistics` \
	reflector `# Simple Pacman Mirror Management` \
	gnu-netcat socat websocat `# Socket Utilities` \
	nnn `# CLI File Manager` \
	avahi	nss-mdns `# mDNS and Network Discovery Utilities` \
	git git-lfs `# Version Control` \
	dua-cli `# Disk Usage Abalyzer` \
	man-db man-pages `# Come On, Man!`

# TODO: if paru? rtx-bin
