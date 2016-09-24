#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source $DIR/variables.bash

pacaur -S \
	mutt-patched smtp-forwarder \
	--noconfirm --noedit

mkdir -p "$DOTFILES_PATH/email/mutt/config/wraithx2/bodies"
mkdir -p "$DOTFILES_PATH/email/mutt/config/wraithx2/headers"
touch "$DOTFILES_PATH/email/mutt/config/certificates"
