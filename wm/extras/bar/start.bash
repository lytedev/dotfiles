#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"

"$DOTFILES_PATH/wm/extras/bar/run_bar.bash" &
export BAR_PID=$!

echo "$BAR_PID" > "$BAR_PID_FILE"
echo "Starting bar with PID $BAR_PID"

xdo lower -a wmpanel

