#!/usr/bin/env bash

while read -r line; do
	COMMAND=$(echo "$line" | awk '{print $1;}')
	ARGS=$(echo "$line" | awk '{for (i=2; i<=NF; i++) print $i}')
	case $COMMAND in
		switch_desktop)
			bspc desktop -f $ARGS
			;;
		launcher)
			rofi -show run -font "$PRIMARY_FONT_FAMILY $PRIMARY_FONT_SIZE" -lines 16 -width 10 -padding 8 -fuzzy -bw "$BORDER_WIDTH" -color-enabled -color-window "#$(get_color 00)","#$(get_color 0D)","#$(get_color 0D)","#$(get_color 00)" -color-normal "#$(get_color 00)","#$(get_color 06)","#$(get_color 00)","#$(get_color 0D)","#$(get_color 00)" -separator-style none -hide-scrollbar
			;;
		launcher2)
			rofi -show drun -font "$PRIMARY_FONT_FAMILY $PRIMARY_FONT_SIZE" -lines 16 -width 10 -padding 8 -fuzzy -bw "$BORDER_WIDTH" -color-enabled -color-window "#$(get_color 00)","#$(get_color 0D)","#$(get_color 0D)","#$(get_color 00)" -color-normal "#$(get_color 00)","#$(get_color 06)","#$(get_color 00)","#$(get_color 0D)","#$(get_color 00)" -separator-style none -hide-scrollbar
			;;
	esac
done
