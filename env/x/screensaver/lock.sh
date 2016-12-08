#!/usr/bin/env sh

source "$DOTFILES_PATH/variables.bash"

scrot "$IMG_PATH/.lock/.lock-bg-img.png"
convert "$IMG_PATH/.lock/.lock-bg-img.png" -blur 0x12 "$IMG_PATH/.lock/.lock-bg-img_blurred.png"
rm "$IMG_PATH/.lock/.lock-bg-img.png"
# xscreensaver-command --lock
i3lock -i "$IMG_PATH/.lock/.lock-bg-img_blurred.png"
