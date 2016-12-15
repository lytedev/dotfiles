#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$BAR_PATH/colors.bash"

PRIORITY=38000

MATCH_PREFIX="BM_CLOCK"
MATCH="$MATCH_PREFIX*"

bar_module_clock() {
  echo -e "%{T-}%{F$COLOR_S1}${1:8}%{F-}"
}

export -f bar_module_clock

bar_module_clock_updater() {
  while true; do
    echo -e "$MATCH_PREFIX""$(date +%H.%M.%S)" > "$BAR_FIFO"
    sleep 1
  done
}
export -f bar_module_clock_updater

register_bar_module "$PRIORITY" "$MATCH" "bar_module_clock" "bar_module_clock_updater"
