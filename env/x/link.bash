#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

MODULE_PATH="$DOTFILES_PATH/env/x"

mkdir -p "$HOME/.config/gtk-3.0"
rm -f "$HOME/.xinitrc"
rm -f "$HOME/.Xresources"
rm -f "$HOME/.gtkrc-2.0"
rm -f "$HOME/.config/gtk-3.0/settings.ini"
rm -f "$HOME/.config/compton.conf"
rm -f "$HOME/.xprofile"
ln -s "$MODULE_PATH/xinitrc" "$HOME/.xinitrc"
ln -s "$MODULE_PATH/xresources" "$HOME/.Xresources"
ln -s "$MODULE_PATH/gtk3settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
ln -s "$MODULE_PATH/gtk2rc" "$HOME/.gtkrc-2.0"
ln -s "$MODULE_PATH/compton.conf" "$HOME/.config/compton.conf"
ln -s "$MODULE_PATH/xprofile" "$HOME/.xprofile"

sudo mkdir -p /root/.gtk-3.0/
sudo mkdir -p /root/.config/gtk-3.0/
sudo rm -f "/root/.gtkrc-2.0"
sudo rm -f "/root/.gtk-3.0/settings.ini"
sudo rm -f "/root/.config/gtk-3.0/settings.ini"
sudo ln -s "$MODULE_PATH/gtk2rc" "/root/.gtkrc-2.0"
sudo ln -s "$MODULE_PATH/gtk3settings.ini" "/root/.gtk-3.0/settings.ini"
sudo ln -s "$MODULE_PATH/gtk3settings.ini" "/root/.config/gtk-3.0/settings.ini"

sudo rm -f "/etc/udev/rules.d/90-usb-device-plugin.rules"
sudo ln -s "$MODULE_PATH/udev_rules/90-usb-device-plugin.rules" "/etc/udev/rules.d/90-usb-device-plugin.rules"

source "$MODULE_PATH/xloadresources"

