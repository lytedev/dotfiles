#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$BAR_PATH/colors.bash"

PRIORITY=32000

MATCH_PREFIX="BM_PACAUR"
MATCH="$MATCH_PREFIX*"

bar_module_pacaur() {
  echo -e "%{T-}%{F$COLOR_DARK}pac %{F$COLOR_S4}${1:9}%{F-}"
}
export -f bar_module_pacaur

bar_module_pacaur_updater() {
  while true; do
    if [ -e "/var/lib/pacman/db.lck" ]; then
      sleep 10
    else
      NUM_PACKAGES=$(pacaur -Syq --silent >/dev/null 2>/dev/null && pacaur -Qqu | wc -l)
      echo -e "$MATCH_PREFIX""$NUM_PACKAGES" > "$BAR_FIFO"
      sleep 300
    fi
  done
}
export -f bar_module_pacaur_updater

register_bar_module "$PRIORITY" "$MATCH" "bar_module_pacaur" "bar_module_pacaur_updater"

echo -e "$MATCH_PREFIX"?? > "$BAR_FIFO"
