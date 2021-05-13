#!/usr/bin/env bash

# kanshi will potentially run this more than once
LOCKFILE="/tmp/lytedev-kanshi-workspace-arranging.lock"
[[ -f $LOCKFILE ]] && { echo "Already locked: $LOCKFILE" >&2; exit 1; }

touch "$LOCKFILE"
sleep 0.1

move_workspace() { swaymsg workspace "$1"; swaymsg move workspace to "'$2'"; }
setup_output() { out="$1"; shift; while (($#)); do move_workspace "$1" "$out"; shift; done; }

set -x

setup_output 'Dell Inc. DELL U2720Q CWTM623'             9 8
setup_output 'Dell Inc. DELL U2720Q D3TM623'             6 5
setup_output 'Samsung Electric Company CF791 HTRJ500315' 3 2
setup_output 'Dell Inc. DELL U2720Q CWTM623'             7
setup_output 'Dell Inc. DELL U2720Q D3TM623'             4
setup_output 'Samsung Electric Company CF791 HTRJ500315' 1

rm "$LOCKFILE"
