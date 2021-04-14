#!/usr/bin/env bash

if grep -E -q '^\[multilib\]$' /etc/pacman.conf; then
	echo "Multilib Repository Already Enabled!"
else
	echo "Enabling Multilib Repository (with sudo)..."
	sudo sh -c 'echo -e "\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
fi

yay -Sy --needed --noconfirm \
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
	pass passff-host `# Password Management` \
	hexyl `# CLI Hex Viewer` \
	rsync `# File Transfer` \
	neovim-nightly-bin `# Text Editors` \
	sc-im `# Spreadsheets` \
	unzip `# Simple Unzipping` \
	tmux `# Terminal Multiplexer` \
	kitty `# Almost Better Terminal Emulator` \
	curl `# HTTP Utility` \
	w3m `# Terminal Browser` \
	jq `# CLI for Interacting with JSON` \
	httpie `# httpie and neovim dependencies` \
	docker docker-compose `# Yummy containers` \
	inotify-tools `# Watching` \
	fish `# Shell` \
	time `# GNU time` \
	fortune-mod fortune-mod-archlinux `# Fortune` \
	oath-toolkit `# One-Time Passwords` \
	sysstat `# System Statistics` \
	reflector-simple `# Simplify Mirror Management` \
	inetutils `# netutils` \
	nnn `# CLI File Manager` \
	ntfs-3g `# Windows filesystem stuff` \
	man-db man-pages `# Come On, Man!`
