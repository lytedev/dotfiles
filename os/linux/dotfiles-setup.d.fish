#!/usr/bin/env fish
set me (status -f)
set dfp $argv[1]
set h $argv[2]
set c $argv[3]

pushd (dirname $me)
l sway/config $c/sway/config
l sway/mimeapps.list $c/mimeapps.list
l sway/mimeapps.list $c/sway-mimeapps.list
l sway/mimeapps.list $h/.local/share/applications/mimeapps.list
l sway/lock $c/swaylock/config
l hypr $c/hypr
l mako $c/mako
l kanshi $c/kanshi
l gtk/2rc $h/.gtkrc-2.0
l gtk/2rc $h/.gtkrc
l gtk/3settings.ini $c/gtk-3.0/settings.ini
l waybar $c/waybar
l libinput/gestures.conf $c/libinput-gestures.conf
l zathura $c/zathura
l user-dirs $c/user-dirs.dirs
