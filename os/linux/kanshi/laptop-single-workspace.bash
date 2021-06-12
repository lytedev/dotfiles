
#!/usr/bin/env bash

move_workspace() { swaymsg workspace "$1"; swaymsg move workspace to "'$2'"; }
setup_output() { out="$1"; shift; while (($#)); do move_workspace "$1" "$out"; shift; done; }
setup_output eDP-1 1 2 3 4 5 6 7 8 9
