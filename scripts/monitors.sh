#!/usr/bin/env sh

export LAST_BSPWM_MONITOR=$(bspc query -M | tail -n 1)
export FIRST_BSPWM_MONITOR=$(bspc query -M | head -n 1)
