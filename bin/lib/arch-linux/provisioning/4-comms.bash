#!/usr/bin/env bash

pacaur --needed -S --noconfirm --noedit \
	weechat-poljar-matrix-git weechat-discord-git wee-slack

wcpm="/usr/lib/weechat/python/matrix"
hwcp="${HOME}/.weechat/python"
ln -s "${wcpm}/" "${hwcp}/"
ln -s "${wcpm}.py" "${hwcp}/"
ln -s "${wcpm}.py" "${hwcp}/autoload/"
ln -s "/usr/lib/weechat/python/wee_slack.py" "${hwcp}/"
ln -s "/usr/lib/weechat/python/wee_slack.py" "${hwcp}/autoload/"

# Scripts are in /usr/lib/weechat/python/matrix/contrib/
