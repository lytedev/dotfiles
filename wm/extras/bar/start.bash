#!/usr/bin/env bash

export BAR_PID_FILE="$DOTFILES_PATH/wm_bar.pid"

"$DOTFILES_PATH/wm/extras/bar/run_bar.bash" &

echo "$!" > "$BAR_PID_FILE"
echo "Starting bar with PID $!"

export BAR_PID="$!"

stopbar() {
  kill -SIGINT $(cat "$BAR_PID_FILE")
  rm -f "$BAR_PID_FILE"
}
export -f stopbar

xdo lower -a wmpanel

