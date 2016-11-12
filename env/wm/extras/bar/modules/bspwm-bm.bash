#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$BAR_PATH/colors.bash"

PRIORITY=15000

PID_PREFIX="bspwm"
MATCH_PREFIX="W"
MATCH="$MATCH_PREFIX*"

DESKTOP_SPACER=" "

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
		bname="%{A:$SWITCH_DESKTOP_COMMAND $cname:}${cname}%{A}"
    case $item in
      O*) # focused occupied desktop
        content="${content}%{F$COLOR_HIGHLIGHT}%{U$COLOR_HIGHLIGHT}%{+${ul}}${bname}%{-${ul}}%{U-}%{F-}$DESKTOP_SPACER"
        ;;
      F*) # focused free desktop
        content="${content}%{F$COLOR_DARK}%{U$COLOR_DARK}%{+${ul}}${bname}%{-${ul}}%{U-}%{F-}$DESKTOP_SPACER"
        ;;
      U*) # focused occupied desktop
        content="${content}%{F$COLOR_URGENT}%{U$COLOR_URGENT}%{+${ul}}${bname}%{-${ul}}%{U-}%{F-}$DESKTOP_SPACER"
        ;;
      o*) # occupied desktop
        content="${content}%{F$COLOR_FOREGROUND}${bname}%{F-}$DESKTOP_SPACER"
        ;;
      f*) # free desktop
        content="${content}%{F$COLOR_DARK}${bname}%{F-}$DESKTOP_SPACER"
        ;;
      u*) # urgent desktop
        content="${content}%{F$COLOR_URGENT}${bname}%{F-}$DESKTOP_SPACER"
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

