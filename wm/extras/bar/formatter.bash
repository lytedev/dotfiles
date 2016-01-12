#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$DOTFILES_PATH/wm/extras/bar/colors.bash"

ul="u"
if [ $BAR_UNDERLINE -eq 1 ]; then
  :
else
  ul="o"
fi

export $MODULE_MATCH=
export $MODULE_CALLBACK=
export $MODULE_DATA=

register_bar_module() {
  :
}
export -f register_bar_module

source "$DOTFILES_PATH/wm/extras/bar/modules/*-bm.bash"

while read -r line; do
  content=
  for i in $MODULE_MATCH; do
    content=$content$i
  done

  printf " %s \n" "$content"
done

