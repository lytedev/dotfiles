#!/usr/bin/env bash

export BAR_MONITOR="$(polybar --list-monitors | tail -n 1 | sed -n 's/^\s*\(.*\):.*$/\1/p')"
export BAR_MONITOR="$(polybar --list-monitors | tail -n 2 | head -n 1 | sed -n 's/^\s*\(.*\):.*$/\1/p')"
export BAR_HEIGHT=40
export BAR_ON_TOP=0
export BAR_SIDE_MARGIN=200

MONITOR_WIDTH=$(xrandr | grep "$BAR_MONITOR" | grep -Po ' \d+' | head -n 1)

export BAR_FONT="${BAR_FONT:-$(xrdb -query | sed -ne      's/.*font:\s*xft:\([^:]*\)\:.*$/\1/p' | head -n 1)}"
export BAR_ICON_FONT="${BAR_ICON_FONT:-"Font Awesome 5 Free"}"
export BAR_FONT_SIZE="${BAR_FONT_SIZE:-$(xrdb -query | sed -ne 's/.*font:\s*xft:[^-,]*\=\([0-9]*\).*$/\1/p' | head -n 1)}"
export BAR_ICON_FONT_SIZE="${BAR_ICON_FONT_SIZE:-$((BAR_FONT_SIZE))}"

export GAP=$(bspc wm -d | grep -Po '(windowGap.*?,)' | grep -Po '\-?\d*' | head -n 1)

if [ "$GAP" -lt 0 ]; then
	GAP=0
fi

export BAR_BOTTOM="false"
export BAR_VERTICAL_MARGIN=0
export POS_Y=0

# allow a per-device config to override options
if [ -f "$HOME/.env_bar" ]; then
	source "$HOME/.env_bar"
fi

export BAR_FONT_DECLARATION="${BAR_FONT}:pixelsize=${BAR_FONT_SIZE};1"
export BAR_ICON_FONT_DECLARATION="${BAR_ICON_FONT}:style=Solid:pixelsize=${BAR_ICON_FONT_SIZE};1"
export BAR_ICON_FONT_2_DECLARATION="${BAR_ICON_FONT_2}:style=Regular:pixelsize=${BAR_ICON_FONT_SIZE};1"

export BAR_WIDTH=$((MONITOR_WIDTH - GAP - GAP - BAR_SIDE_MARGIN - BAR_SIDE_MARGIN))
export POS_X=$((GAP + BAR_SIDE_MARGIN))

export EHEIGHT=$((BAR_HEIGHT + GAP + BAR_VERTICAL_MARGIN))

# if we just want the variables set here, pass an argument
if [ $# -gt 0 ]; then
	return
fi

if [ "$BAR_ON_TOP" -eq 1 ]; then
	export BAR_BOTTOM="false"
	export POS_Y=$GAP
	bspc config -m "${BAR_MONITOR}" top_padding "$EHEIGHT"
	bspc config -m "${BAR_MONITOR}" bottom_padding "0"
else
	export BAR_BOTTOM="true"
	export POS_Y=$GAP
	bspc config -m "${BAR_MONITOR}" top_padding "0"
	bspc config -m "${BAR_MONITOR}" bottom_padding "$EHEIGHT"
fi

# bspc

polybar lytedev
