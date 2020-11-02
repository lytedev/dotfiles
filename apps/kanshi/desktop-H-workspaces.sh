#!/usr/bin/env bash

# kanshi will potentially run this more than once
LOCKFILE="/tmp/kanshi-workspace-arranging.lock"
if ! (set -o noclobber; echo > "$LOCKFILE"); then exit 1; fi
touch "$LOCKFILE"
# TODO: some way to ensure the lock file is cleaned up?
# maybe check if the file is older than a minute?

move_workspace() { swaymsg workspace "$1"; swaymsg move workspace to "'$2'"; }
setup_output() { out="$1"; shift; while (($#)); do move_workspace "$1" "$out"; shift; done; }

setup_output 'Dell Inc. DELL U2719DC 9DL4QS2'            9 8 7
setup_output 'Dell Inc. DELL U2719DC 5DL4QS2'            6 5 4
setup_output 'Samsung Electric Company CF791 HTRJ500315' 3 2 1

rm "$LOCKFILE"
