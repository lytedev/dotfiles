#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$BAR_PATH/colors.bash"

PRIORITY=15000

PID_PREFIX="bspwm"
MATCH_PREFIX="W"
MATCH="$MATCH_PREFIX*"

DESKTOP_SPACE_BEFORE=""
DESKTOP_SPACE_AFTER=""

SWITCH_DESKTOP_COMMAND="switch_desktop"

ul="u"
if [ $BAR_UNDERLINE -eq 1 ]; then
  :
else
  ul="o"
fi

bar_module_bspwm() {
  content="%{F$COLOR_FOREGROUND}"
  line=$1
  IFS=':'
  set -- ${line#?}
  while [ $# -gt 0 ] ; do
    item=$1
    name=${item#?}
    cname="$name"
		bname=" %{A:$SWITCH_DESKTOP_COMMAND $cname:}${cname}%{A} "
    case $item in
      O*) # focused occupied desktop
        content="$DESKTOP_SPACE_BEFORE${content}%{B$COLOR_HIGHLIGHT}%{F$COLOR_BACKGROUND}%{U$COLOR_HIGHLIGHT}%{+${ul}}${bname}%{-${ul}}%{U-}%{F-}%{B-}$DESKTOP_SPACE_AFTER"
        ;;
      F*) # focused free desktop
        content="$DESKTOP_SPACE_BEFORE${content}%{B$COLOR_DARK}%{F$COLOR_BACKGROUND}%{U$COLOR_HIGHLIGHT}%{+${ul}}${bname}%{-${ul}}%{U-}%{F-}%{B-}$DESKTOP_SPACE_AFTER"
        ;;
      U*) # urgent focused desktop
        content="$DESKTOP_SPACE_BEFORE${content}%{B$COLOR_URGENT}%{F$COLOR_BACKGROUND}%{U$COLOR_HIGHLIGHT}%{+${ul}}${bname}%{-${ul}}%{U-}%{F-}%{B-}$DESKTOP_SPACE_AFTER"
        ;;
      o*) # occupied unfocused desktop
        content="$DESKTOP_SPACE_BEFORE${content}%{F$COLOR_FOREGROUND}${bname}%{F-}$DESKTOP_SPACE_AFTER"
        ;;
      f*) # free desktop
        content="$DESKTOP_SPACE_BEFORE${content}%{F$COLOR_DARK}${bname}%{F-}$DESKTOP_SPACE_AFTER"
        ;;
      u*) # urgent desktop
        content="$DESKTOP_SPACE_BEFORE${content}%{B$COLOR_URGENT}%{F$COLOR_BACKGROUND}%{U$COLOR_HIGHLIGHT}%{+${ul}}${bname}%{-${ul}}%{U-}%{F-}%{B-}$DESKTOP_SPACE_AFTER"
        ;;
    esac
    shift
  done
  echo -e "$content"
}
export -f bar_module_bspwm

bar_module_bspwm_updater()
{
	bspc subscribe all > "$BAR_FIFO"
}
export -f bar_module_bspwm_updater

register_bar_module "$PRIORITY" "$MATCH" "bar_module_bspwm" "bar_module_bspwm_updater"

