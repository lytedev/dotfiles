#!/usr/bin/env bash

# kanshi will potentially run this more than once
LOCKFILE="/tmp/lytedev-kanshi-workspace-arranging.lock"
if ! [[ -f $LOCKFILE ]]; then
	touch "$LOCKFILE"
	sleep 0.1
	echo "L: $(date)" >> /tmp/kanshilog
	# TODO: some way to ensure the lock file is cleaned up?
	# maybe check if the file is older than a minute?

	move_workspace() { swaymsg workspace "$1"; swaymsg move workspace to "'$2'"; }
	setup_output() { out="$1"; shift; while (($#)); do move_workspace "$1" "$out"; shift; done; }

	set -x
	# setup_output 'Dell Inc. DELL U2719DC 9DL4QS2'            7 8 9
	# setup_output 'Dell Inc. DELL U2719DC 5DL4QS2'            4 5 6
	# setup_output 'Samsung Electric Company CF791 HTRJ500315' 1 2 3

	setup_output 'Dell Inc. DELL U2719DC 9DL4QS2'            9 8
	setup_output 'Dell Inc. DELL U2719DC 5DL4QS2'            6 5
	setup_output 'Samsung Electric Company CF791 HTRJ500315' 3 2
	setup_output 'Dell Inc. DELL U2719DC 9DL4QS2'            7
	setup_output 'Dell Inc. DELL U2719DC 5DL4QS2'            4
	setup_output 'Samsung Electric Company CF791 HTRJ500315' 1

	# setup_output 'Dell Inc. DELL U2719DC 9DL4QS2'            8 9 7
	# setup_output 'Dell Inc. DELL U2719DC 5DL4QS2'            5 6 4
	# setup_output 'Samsung Electric Company CF791 HTRJ500315' 2 3 1

	rm "$LOCKFILE"
else
	echo "F: $(date)" >> /tmp/kanshilog
	echo "Already locked: $LOCKFILE" >&2
	exit 1
fi
