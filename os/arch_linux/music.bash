#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source $DIR/variables.bash

pacaur -S \
	mopidy mopidy-spotify mopidy-gmusic \
	ncmpcpp mpd \
	--noconfirm --noedit
