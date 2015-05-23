#!/usr/bin/env bash

float_mul_int()
{
  printf "%.0f\n" $(echo $1 $2 | awk '{ print $1*$2 }')
}

float_div()
{
  printf "%f\n" $(echo $1 $2 | awk '{ print $1/$2 }')
}

float_div_int()
{
  printf "%.0f\n" $(echo $1 $2 | awk '{ print $1/$2 }')
}

float_add()
{
  printf "%f\n" $(echo $1 $2 | awk '{ print $1+$2 }')
}

float_add_int()
{
  printf "%.0f\n" $(echo $1 $2 | awk '{ print $1+$2 }')
}

float_sub()
{
  printf "%f\n" $(echo $1 $2 | awk '{ print $1-$2 }')
}

float_sub_int()
{
  printf "%.0f\n" $(echo $1 $2 | awk '{ print $1-$2 }')
}

get_brightness()
{
  cat /sys/class/backlight/intel_backlight/brightness
}

get_max_brightness()
{
  cat /sys/class/backlight/intel_backlight/max_brightness
}

get_brightness_percent()
{
  float_div $(get_brightness) $(get_max_brightness)
}

set_percent_brightness()
{
  MAX_BRIGHTNESS=$(get_max_brightness)
  NEW_BRIGHTNESS=$(float_mul_int $1 $MAX_BRIGHTNESS)
  sudo -H -u root bash -c "echo $NEW_BRIGHTNESS > /sys/class/backlight/intel_backlight/brightness"
}

add_percent_brightness()
{
  BRIGHTNESS_PERCENT=$(get_brightness_percent)
  set_percent_brightness $(float_add $1 $BRIGHTNESS_PERCENT)
}

sub_percent_brightness()
{
  BRIGHTNESS_PERCENT=$(get_brightness_percent)
  set_percent_brightness $(float_sub $BRIGHTNESS_PERCENT $1)
}
