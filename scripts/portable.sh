#!/usr/bin/env bash

rm -f "$HOME/.bashrc_env"
rm -f "$HOME/.Xresource.env"
ln -s "$DOTFILES_PATH/shell/bashrc_env_portable" "$HOME/.bashrc_env"
ln -s "$DOTFILES_PATH/wm/xorg/Xresources_env_portable" "$HOME/.Xresources.env"

xrdb -merge "$HOME/.Xresources.env"

