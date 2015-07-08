#!/usr/bin/env bash

CODE_DIR=~/Documents/Code
SUBDIR=/repos

FINAL_CODE_DIR="$CODE_DIR$SUBDIR/"

chmod 600 creds
sudo npm install -g gmusic-mpd
cd "$FINAL_CODE_DIR" && git clone git@github.com:simon-weber/Unofficial-Google-Music-API.git gmusicapi
cd "$FINAL_CODE_DIR"gmusicapi && sudo pip2 install -r "$FINAL_CODE_DIR"gmusicapi/requirements.txt
cd "$FINAL_CODE_DIR" && git clone https://github.com/diraimondo/gmusicproxy.git gmusicproxy
cd "$FINAL_CODE_DIR"gmusicproxy && sudo pip2 install -r "$FINAL_CODE_DIR"gmusicproxy/requirements.txt
rm -f $HOME/.config/gmusicproxy.cfg
ln -s $DOTFILES_PATH/apps/gmusic/creds $HOME/.config/gmusicproxy.cfg

