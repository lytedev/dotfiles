#!/usr/bin/env bash

float_mul_int()
{
  printf "%.0f\n" $(echo $1 $2 | awk '{ print $1*$2 }')
}
export -f float_mul_int

float_div()
{
  printf "%f\n" $(echo $1 $2 | awk '{ print $1/$2 }')
}
export -f float_div

float_div_int()
{
  printf "%.0f\n" $(echo $1 $2 | awk '{ print $1/$2 }')
}
export -f float_div_int

float_add()
{
  printf "%f\n" $(echo $1 $2 | awk '{ print $1+$2 }')
}
export -f float_add

float_add_int()
{
  printf "%.0f\n" $(echo $1 $2 | awk '{ print $1+$2 }')
}
export -f float_add_int

float_sub()
{
  printf "%f\n" $(echo $1 $2 | awk '{ print $1-$2 }')
}
export -f float_sub

float_sub_int()
{
  printf "%.0f\n" $(echo $1 $2 | awk '{ print $1-$2 }')
}
export -f float_sub_int

get_brightness()
{
  cat /sys/class/backlight/intel_backlight/brightness
}
export -f get_brightness

get_max_brightness()
{
  cat /sys/class/backlight/intel_backlight/max_brightness
}
export -f get_max_brightness

get_brightness_percent()
{
  float_div $(get_brightness) $(get_max_brightness)
}
export -f get_brightness_percent

set_percent_brightness()
{
  MAX_BRIGHTNESS=$(get_max_brightness)
  NEW_BRIGHTNESS=$(float_mul_int $1 $MAX_BRIGHTNESS)
  sudo -H -u root bash -c "echo $NEW_BRIGHTNESS > /sys/class/backlight/intel_backlight/brightness"
}
export -f set_percent_brightness

add_percent_brightness()
{
  BRIGHTNESS_PERCENT=$(get_brightness_percent)
  set_percent_brightness $(float_add $1 $BRIGHTNESS_PERCENT)
}
export -f add_percent_brightness

sub_percent_brightness()
{
  BRIGHTNESS_PERCENT=$(get_brightness_percent)
  set_percent_brightness $(float_sub $BRIGHTNESS_PERCENT $1)
}
export -f sub_percent_brightness

