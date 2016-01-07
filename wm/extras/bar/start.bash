#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"

trap killbar INT TERM QUIT EXIT

function killbar() {
  if [ $BAR_TOP -eq 1 ]; then
    bspc config -m $(bspc query -M | head -n 1) top_padding "0"
  else
    bspc config -m $(bspc query -M | head -n 1) bottom_padding "0"
  fi
}

if [ $BAR_TOP -eq 1 ]; then
  bspc config -m $(bspc query -M | head -n 1) top_padding "$BAR_HEIGHT"
else
  bspc config -m $(bspc query -M | head -n 1) bottom_padding "$BAR_HEIGHT"
fi

# get width of our main monitor
WIDTH=`xrandr -q | egrep '(^| )connected( |$)' | tr 'x' '\n' | head -n 1 | awk '{print $NF}'`
WIDTH=$((WIDTH-BAR_MARGIN-BAR_MARGIN))
HEIGHT=`xrandr -q | egrep '(^| )connected( |$)' | tr '+' '\n' | tr 'x' '\n' | head -n 2 | tail -n 1`

POS_Y=0
if [ $BAR_TOP -eq 1 ]; then
  :
else
  POS_Y=$((HEIGHT-BAR_HEIGHT))
fi

lemonbar -g "$WIDTH"x"$BAR_HEIGHT"+"$BAR_MARGIN"+"$POS_Y"
