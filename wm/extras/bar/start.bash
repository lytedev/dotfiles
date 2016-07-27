#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"

export BAR_RUNNING=1
function killbar() {
  export BAR_RUNNING=0
  if [ $BAR_TOP -eq 1 ]; then
    bspc config -m $(bspc query -M | head -n 1) top_padding "0"
  else
    bspc config -m $(bspc query -M | head -n 1) bottom_padding "0"
  fi
	for f in $(ls "$DOTFILES_PATH"/wm/extras/bar/modules/*.pid 2>/dev/null); do
		# echo "KILLING MODULE PROCESS $f WITH PID $(cat "$f")"
		# kill -SIGTERM $(cat "$f")
		rm "$f"
	done
	kill $!
	# kill -SIGTERM $BARPID
}
export -f killbar

trap killbar INT TERM QUIT EXIT

rm -f "$BAR_FIFO"
mkfifo "$BAR_FIFO"

if [ $BAR_TOP -eq 1 ]; then
  bspc config -m $(bspc query -M | head -n 1) top_padding "$BAR_HEIGHT"
else
  bspc config -m $(bspc query -M | head -n 1) bottom_padding "$BAR_HEIGHT"
fi

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

echo $COLOR_FOREGROUND
echo $COLOR_DARK
echo $COLOR_BACKGROUND
echo $COLOR_HIGHLIGHT
echo $COLOR_URGENT

echo $COLOR_S1
echo $COLOR_S2
echo $COLOR_S3
echo $COLOR_S4
echo $COLOR_S5


cat "$BAR_FIFO" | "$DOTFILES_PATH/wm/extras/bar/formatter.bash" | \
	lemonbar $BAR_B -g "$WIDTH"x"$BAR_HEIGHT"+"$BAR_MARGIN"+"$POS_Y" -u "$BAR_BORDER_WIDTH" -f "$BAR_FONT_FAMILY" -F "$COLOR_FOREGROUND" -B"$COLOR_BACKGROUND" -n "$BAR_WID"
