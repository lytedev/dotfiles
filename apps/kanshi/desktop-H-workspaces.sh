#!/usr/bin/env sh

set -x

uw='Samsung Electric Company CF791 HTRJ500315'
l='Dell Inc. DELL U2719DC 5DL4QS2'
r='Dell Inc. DELL U2719DC 9DL4QS2'

mws() {
  swaymsg workspace "$1", move workspace to output "\"$2\""
}

mws 5 "$l"
mws 6 "$l"
mws 4 "$l"

mws 8 "$r"
mws 9 "$r"
mws 7 "$r"

mws 2 "$uw"
mws 3 "$uw"
mws 1 "$uw"

