#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$DOTFILES_PATH/wm/extras/bar/colors.bash"

PRIORITY=12000

MATCH_PREFIX="BM_PACAUR"
MATCH="$MATCH_PREFIX*"

bar_module_pacaur() {
  echo -e "%{T-}%{F$COLOR_DARK}pac %{F$COLOR_S1}${1:9}%{F-}"
}

export -f bar_module_pacaur
register_bar_module "$PRIORITY" "$MATCH" "bar_module_pacaur"

bar_module_pacaur_updater() {
  while true; do
    NUM_PACKAGES=$(pacaur -Syq > /dev/null && pacaur -Qqu | wc -l)
    echo -e "$MATCH_PREFIX""$NUM_PACKAGES" > "$BAR_FIFO"
    sleep 300
  done
}
bar_module_pacaur_updater &

echo -e "$MATCH_PREFIX"?? > "$BAR_FIFO"
