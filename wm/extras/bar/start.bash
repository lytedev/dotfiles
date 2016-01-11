#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"

function killbar() {
  if [ $BAR_TOP -eq 1 ]; then
    bspc config -m $(bspc query -M | head -n 1) top_padding "0"
  else
    bspc config -m $(bspc query -M | head -n 1) bottom_padding "0"
  fi
}

trap killbar INT TERM QUIT EXIT

rm -f "$BAR_FIFO"
mkfifo "$BAR_FIFO"

if [ $BAR_TOP -eq 1 ]; then
  bspc config -m $(bspc query -M | head -n 1) top_padding "$BAR_HEIGHT"
else
  bspc config -m $(bspc query -M | head -n 1) bottom_padding "$BAR_HEIGHT"
fi

bspc subscribe all > "$BAR_FIFO" &

# get width of our main monitor
WIDTH=`xrandr -q | egrep '(^| )connected( |$)' | tr 'x' '\n' | head -n 1 | awk '{print $NF}'`
WIDTH=$((WIDTH-BAR_MARGIN-BAR_MARGIN))

BAR_B=""
if [ $BAR_TOP -eq 1 ]; then
  :
else
  BAR_B="-b"
fi

source "$DOTFILES_PATH/wm/extras/bar/colors.bash"

cat "$BAR_FIFO" | "$DOTFILES_PATH/wm/extras/bar/formatter.bash" | lemonbar $BAR_B -d -g "$WIDTH"x"$BAR_HEIGHT"+"$BAR_MARGIN"+"$POS_Y" -u "$BAR_BORDER_WIDTH" -f "$BAR_FONT_FAMILY" -F "$COLOR_FOREGROUND" -B "$COLOR_BACKGROUND"
