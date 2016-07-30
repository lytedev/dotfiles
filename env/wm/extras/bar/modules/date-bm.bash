#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$BAR_PATH/colors.bash"

PRIORITY=35000

MATCH_PREFIX="BM_DATE"
MATCH="$MATCH_PREFIX*"

bar_module_date() {
  echo -e "%{T-}%{r}%{F$COLOR_S2}${1:7}%{F-}"
}
export -f bar_module_date

bar_module_date_updater() {
  while true; do
    echo -e "$MATCH_PREFIX""$(date +'%a %b %d')" > $BAR_FIFO
    sleep 60
  done
}
export -f bar_module_date_updater

register_bar_module "$PRIORITY" "$MATCH" "bar_module_date" "bar_module_date_updater"
