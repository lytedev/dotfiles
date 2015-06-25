DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
rm -f "$HOME/.xinitrc"
rm -f "$HOME/.Xresources"
rm -f "$HOME/.config/bspwm/bspwmrc"
rm -f "$HOME/.config/sxhkd/sxhkdrc"
rm -f "$HOME/.config/sxhkd/altsxhkdrc"
ln -s "$DIR/wm/xorg/xinitrc" "$HOME/.xinitrc"
ln -s "$DIR/wm/xorg/Xresources" "$HOME/.Xresources"
ln -s "$DIR/wm/bspwmrc" "$HOME/.config/bspwm/bspwmrc"
ln -s "$DIR/wm/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"
ln -s "$DIR/wm/altsxhkdrc" "$HOME/.config/sxhkd/altsxhkdrc"

