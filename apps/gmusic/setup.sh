#!/usr/bin/env bash

chmod 600 creds
sudo npm install -g gmusic-mpd
cd /home/daniel/code/repos/ && git clone git@github.com:simon-weber/Unofficial-Google-Music-API.git gmusicapi
cd /home/daniel/code/repos/gmusicapi && sudo pip2 install -r /home/daniel/code/repos/gmusicapi/requirements.txt
cd /home/daniel/code/repos/ && git clone https://github.com/diraimondo/gmusicproxy.git gmusicproxy
cd /home/daniel/code/repos/gmusicproxy && sudo pip2 install -r /home/daniel/code/repos/gmusicproxy/requirements.txt
rm -f $HOME/.config/gmusicproxy.cfg
ln -s $DOTFILES_PATH/apps/gmusic/creds $HOME/.config/gmusicproxy.cfg

