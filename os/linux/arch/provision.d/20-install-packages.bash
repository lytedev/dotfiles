#!/usr/bin/env bash

# if grep -E -q '^\[multilib\]$' /etc/pacman.conf; then
# 	echo "Multilib Repository Already Enabled!"
# else
# 	echo "Enabling Multilib Repository (with sudo)..."
# 	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
# fi

paru -Sy --needed --noconfirm \
	fswatch watchexec \
	fwupd \
	docker `# Containers` \
	ncdu `# Disk Usage Analyzer` \
	efibootmgr efivar `# UEFI Boot CLI Stuff` \
	weechat `# IRC Client` \
	aria2 `# Downloads Manager` \
	dmenu `# Application Launcher` \
	ripgrep `# Code Search Utilities` \
	fd `# File Search` \
	exa `# Better ls` \
	sd `# Easy Find/Replace` \
	bat `# Better Cat` \
	fzf `# Fuzzy File Finder` \
	htop `# Process Management and System Resources Monitoring` \
	openssh mosh `# Remote Access` \
	openssl `# Crypto` \
	asdf-vm `# Runtime Version Manager` \
	pass pass-otp `# Password Management` \
	hexyl `# CLI Hex Viewer` \
	rsync `# File Transfer` \
	neovim `# Text Editors` \
	unzip `# Simple Unzipping` \
	tmux `# Terminal Multiplexer` \
	kitty-terminfo `# Almost Better Terminal Emulator` \
	curl `# It's curl, c'mon` \
	w3m `# Terminal Browser` \
	jq `# CLI for Interacting with JSON` \
	xh `# New HTTP Utility` \
	age sops `# Simple Secretes Managements` \
	inotify-tools `# Watching` \
	fish `# Shell` \
	time `# GNU time` \
	fortune-mod fortune-mod-archlinux `# Fortune` \
	oath-toolkit `# One-Time Passwords` \
	sysstat `# System Statistics` \
	reflector `# Simplify Mirror Management` \
	inetutils `# netutils` \
	nnn `# CLI File Manager` \
	man-db man-pages `# Come On, Man!`
