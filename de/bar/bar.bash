#!/usr/bin/env bash

export BAR_MONITOR="DVI-I-2"
export BAR_HEIGHT=25
export BAR_ON_TOP=0
export BAR_SIDE_MARGIN=200

export GAP=$(bspc wm -d | grep -Po '(windowGap.*?,)' | grep -Po '\d*' | head -n 1)
MONITOR_WIDTH=$(xrandr | grep DVI-I-2 | grep -Po ' \d+' | head -n 1)
export BAR_WIDTH=$((MONITOR_WIDTH - GAP - GAP - BAR_SIDE_MARGIN - BAR_SIDE_MARGIN))
export BAR_FONT=$(xrdb -query | sed -ne      's/.*font:\s*xft:\(.*\)\-.*$/\1/p' | head -n 1)
export BAR_FONT_SIZE=$(xrdb -query | sed -ne 's/.*font:\s*xft:.*\-\(.*\)$/\1/p' | head -n 1)
export POS_X=$((GAP + BAR_SIDE_MARGIN))

export BAR_FONT_DECLARATION="${BAR_FONT}:pixelsize=${BAR_FONT_SIZE};1"

EHEIGHT=$((BAR_HEIGHT + GAP))

export BAR_BOTTOM="true"
export POS_Y=0
if [ $BAR_ON_TOP -eq 1 ]; then
	export BAR_BOTTOM="false"
	export POS_Y=$GAP
	bspc config -m ${BAR_MONITOR} top_padding "$EHEIGHT"
	bspc config -m ${BAR_MONITOR} bottom_padding "0"
else
	export POS_Y=$GAP
	bspc config -m ${BAR_MONITOR} top_padding "0"
	bspc config -m ${BAR_MONITOR} bottom_padding "$EHEIGHT"
fi


bspc

polybar lytedev