#!/usr/bin/env sh

get_color()
{
  XR_COLOR_DEF=$(grep "#define base$1 #" ~/.Xresources.colors)
  echo ${XR_COLOR_DEF:16}
}
export -f get_color

