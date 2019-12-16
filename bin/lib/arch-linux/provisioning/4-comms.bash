#!/usr/bin/env bash

pacaur --needed -S --noconfirm --noedit \
	weechat-poljar-matrix-git weechat-discord-git

ln -s /usr/lib/weechat/python/matrix/   ~/.weechat/python/
ln -s /usr/lib/weechat/python/matrix.py ~/.weechat/python/

ln -s /usr/lib/weechat/python/matrix.py ~/.weechat/python/autoload/

# Scripts are in /usr/lib/weechat/python/matrix/contrib/
