#!/bin/sh

source "$DOTFILES_PATH/variables.bash"
source "$DOTFILES_PATH/scripts/get_color.sh"
source "$DOTFILES_PATH/scripts/get_x_fonts.sh"

# cat ../colors/xresources | \
# 	sed -n 's/.*base\([0-9A-F]*\)\s\(.*\)$/\1 \2/p' | \
# 	(while read line; do printf '\033]4;%s;%s' $line; done;)

printf '\33]50;%s\007' "xft:$PRIMARY_FONT_FAMILY_WITH_SIZE"
printf '\33]11;%s\007' "#$(get_color 00)"
printf '\33]10;%s\007' "#$(get_color 05)"

XRES_FILE="$HOME/.Xresources.colors"

read -d '' map << EOF
$(cat "$XRES_FILE" | \
	sed -n 's/.*\(base[0-9A-F]*\)\s*\(#.*\)$/\1 \2/p')
EOF

read -d '' values << EOF
$(cat "$XRES_FILE" | \
	sed -n 's/.*color\([0-9]*\):\s*\(base.*\)$/\1 \2/p')
EOF

declare -A maparr
while read -r line; do
	read -a a <<< $line
	maparr[${a[0]}]=${a[1]}
done <<< "$map"

declare -A previous_colors
while read -r line; do
	read -a a <<< $line
	col=${maparr[${a[1]}]}
	if [ ${a[0]} -gt "8" ]; then
		col=${maparr[${previous_colors["color$(expr ${a[0]} - 8)"]}]}
	fi
	printf '\33]4;%s;%s\007' ${a[0]} $col
	previous_colors["color${a[0]}"]="${a[1]}"
done <<< "$values"

xrdb -merge "$HOME/.Xresources"
xrdb -merge "$HOME/.Xresources.colors"
xrdb -merge "$HOME/.Xresources.env"

