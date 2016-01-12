#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$DOTFILES_PATH/wm/extras/bar/colors.bash"

PRIORITY=2500

MATCH_PREFIX="W"
MATCH="$MATCH_PREFIX*"

ul="u"
if [ $BAR_UNDERLINE -eq 1 ]; then
  :
else
  ul="o"
fi

bar_module_bspwm() {
  content="%{F$COLOR_FOREGROUND}%{c}"
  line=$1
  IFS=':'
  set -- ${line#?}
  while [ $# -gt 0 ] ; do
    item=$1
    name=${item#?}
    cname="$name"
    case $item in
      O*) # focused occupied desktop
        content="${content} %{F$COLOR_HIGHLIGHT}%{U$COLOR_HIGHLIGHT}%{+${ul}}${cname}%{-${ul}}%{U-}%{F-}"
        ;;
      F*) # focused free desktop
        content="${content} %{F$COLOR_DARK}%{U$COLOR_DARK}%{+${ul}}${cname}%{-${ul}}%{U-}%{F-}"
        ;;
      U*) # focused occupied desktop
        content="${content} %{F$COLOR_URGENT}%{U$COLOR_URGENT}%{+${ul}}${cname}%{-${ul}}%{U-}%{F-}"
        ;;
      o*) # occupied desktop
        content="${content} %{F$COLOR_FOREGROUND}${cname}%{F-}"
        ;;
      f*) # free desktop
        content="${content} %{F$COLOR_DARK}${cname}%{F-}"
        ;;
      u*) # urgent desktop
        content="${content} %{F$COLOR_URGENT}${cname}%{F-}"
        ;;
    esac
    shift
  done
  echo -e "$content"
}
export -f bar_module_bspwm
register_bar_module "$PRIORITY" "$MATCH" "bar_module_bspwm"

bspc subscribe all > "$BAR_FIFO" &

