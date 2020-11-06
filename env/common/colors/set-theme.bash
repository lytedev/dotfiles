#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)

THEME="$1"

echo "$THEME"

"$DIR/generator/gen.bash" "$THEME"
"$DOTFILES_PATH/apps/de/x/loadresources"
resrc
restartbar
# TODO: set GTK theme to "Arc-Dark" or "Arc-Light"
