#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$DOTFILES_PATH/wm/extras/bar/colors.bash"

ul="u"
if [ $BAR_UNDERLINE -eq 1 ]; then
  :
else
  ul="o"
fi

while read -r line; do
  case $line in
    # bspwm
    W*)
      wm_info=""
      IFS=':' # this is some magic variable... you need it
      set -- ${line#?}
      while [ $# -gt 0 ]; do
        item=$1
        name=${item#?}
        cname="$name"
        case $item in
          M*)
            # active monitor
            # do nothing
            ;;
          m*)
            # inactive monitor
            # do nothing
            ;;
          O*)
            # focused occupied desktop
            wm_info="${wm_info} %{F$COLOR_HIGHLIGHT}%{U$COLOR_HIGHLIGHT}%{+${ul}}${cname}%{-${ul}}%{U-}%{F-}"
            ;;
          F*)
            # focused free desktop
            wm_info="${wm_info} %{F$COLOR_DARK}%{U$COLOR_DARK}%{+${ul}}${cname}%{-${ul}}%{U-}%{F-}"
            ;;
          U*)
            # focused occupied desktop
            wm_info="${wm_info} %{F$COLOR_URGENT}%{U$COLOR_URGENT}%{+${ul}}${cname}%{-${ul}}%{U-}%{F-}"
            ;;
          o*)
            # occupied desktop
            wm_info="${wm_info} %{F$COLOR_FOREGROUND}${cname}%{F-}"
            ;;
          f*)
            # free desktop
            wm_info="${wm_info} %{F$COLOR_DARK}${cname}%{F-}"
            ;;
          u*)
            # urgent desktop
            wm_info="${wm_info} %{F$COLOR_URGENT}${cname}%{F-}"
            ;;
          L*)
            # layout
            ;;
        esac
        shift
      done
      ;;
  esac
  printf " %s \n" "%{T1}What up, bar? %{c}${wm_info} %{r}Clock here or something"
done

