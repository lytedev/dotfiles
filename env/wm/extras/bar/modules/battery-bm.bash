#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$BAR_PATH/colors.bash"

PRIORITY=31000

MATCH_PREFIX="BM_BATTERY"
MATCH="$MATCH_PREFIX*"

bar_module_battery() {
  echo -e "%{T-}%{F$COLOR_DARK}bat %{F$COLOR_S3}${1:10}%{F-}"
}
export -f bar_module_battery

bar_module_battery_updater() {
  while true; do
    echo -e "$MATCH_PREFIX""$(cat /sys/class/power_supply/BAT*/capacity)" > $BAR_FIFO
    sleep 60
  done
}
export -f bar_module_battery_updater

TYPE_RBM="$(type -t register_bar_module)"
if [[ -n "$TYPE_RBM" ]] && [[ "$TYPE_RBM" = function ]]; then
	register_bar_module "$PRIORITY" "$MATCH" "bar_module_battery" "bar_module_battery_updater"
fi
