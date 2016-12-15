#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
PRIORITY=30505
MATCH_PREFIX="BM_BL"
MATCH="$MATCH_PREFIX*"

bar_module_backlight() {
  echo -e "%{T-}%{F$COLOR_DARK}lit %{F$COLOR_S5}${1:5}%{F-}"
}
export -f bar_module_backlight

bar_module_backlight_updater() {
  while [ $BAR_RUNNING -eq 1 ]; do
		# echo -e "$MATCH_PREFIX""$(xbacklight | sed 's/\.[0-9]*//')" > "$BAR_FIFO"
    sleep 5
  done
}
export -f bar_module_backlight_updater

# Optional: Initialize that module by immediately writing to the FIFO using your
# prefix to show some default information on the bar when it loads.
echo -e "$MATCH_PREFIX"??? > "$BAR_FIFO"

# Register our module so that it is started once the bar is ready
register_bar_module "$PRIORITY" "$MATCH" "bar_module_backlight" "bar_module_backlight_updater"

