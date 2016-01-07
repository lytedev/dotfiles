#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)
source "$DIR/variables.bash"

mkdir -p "$HOME/.config/gtk-3.0"
rm -f "$HOME/.xinitrc"
rm -f "$HOME/.Xresources"
rm -f "$HOME/.config/gtkrc-2.0"
rm -f "$HOME/.config/gtk-3.0/settings.ini"
ln -s "$DOTFILES_PATH/x/xinitrc" "$HOME/.xinitrc"
ln -s "$DOTFILES_PATH/x/xresources" "$HOME/.Xresources"
ln -s "$DOTFILES_PATH/x/gtk3settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
ln -s "$DOTFILES_PATH/x/gtk2rc" "$HOME/.config/gtkrc-2.0"

sudo mkdir -p /root/.gtk-3.0/
sudo mkdir -p /root/.config/gtk-3.0/
sudo rm -f "/root/.gtkrc-2.0"
sudo rm -f "/root/.gtk-3.0/settings.ini"
sudo rm -f "/root/.config/gtk-3.0/settings.ini"
sudo ln -s "$DOTFILES_PATH/x/gtk2rc" "/root/.gtkrc-2.0"
sudo ln -s "$DOTFILES_PATH/x/gtk3settings.ini" "/root/.gtk-3.0/settings.ini"
sudo ln -s "$DOTFILES_PATH/x/gtk3settings.ini" "/root/.config/gtk-3.0/settings.ini"

source "$DOTFILES_PATH/x/xloadresources"

