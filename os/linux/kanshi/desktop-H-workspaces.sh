#!/usr/bin/env bash

# kanshi will potentially run this more than once
LOCKFILE="/tmp/lytedev-kanshi-workspace-arranging.lock"
[[ -f $LOCKFILE ]] && { echo "Already locked: $LOCKFILE" >&2; exit 1; }

touch "$LOCKFILE"
sleep 0.1

move_workspace() { swaymsg workspace "$1"; swaymsg move workspace to "'$2'"; }
setup_output() { out="$1"; shift; while (($#)); do move_workspace "$1" "$out"; shift; done; }

set -x

setup_output 'Dell Inc. DELL U2720Q CWTM623'             9
setup_output 'Dell Inc. DELL U2720Q D3TM623'             8
setup_output 'Samsung Electric Company CF791 HTRJ500315' 2 3 4 5 6 7 1

rm "$LOCKFILE"
