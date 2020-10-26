#!/usr/bin/env bash

sudo apt install curl gnupg2

echo "Setting up yarn source..."
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt remove cmdtest # conflicts with yarn

sudo apt update

sudo apt install \
	tmux \
	fish \
	fd-find \
	ripgrep \
	tree \
	fzf \
	htop \
	ssh mosh \
	openssl \
	python3 python3-pip \
	rsync \
	neovim vim \
	unzip \
	lua5.3 luajit \
	jq \
	w3m \
	ranger \
	inotify-tools \
	time \
	fortune \
	nodejs yarn \
	gawk \
	netcat \
	kitty-terminfo
