#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"
source "$DOTFILES_PATH/wm/extras/bar/colors.bash"

reserve_bar_module_pid() {
	FILE="$DOTFILES_PATH/wm/extras/bar/modules/$1.bm.pid"
	if [[ -f "$FILE" ]]; then

		return 1
	else
		echo "Starting bar module $1 witrh PID $!"
		$2 &
		return 0
	fi
}

