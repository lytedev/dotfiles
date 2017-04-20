#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)

source "$DOTFILES_PATH/de/bar/bar.bash" --just-vars=1

export BG_COLOR=$(xrdb -query | sed -ne 's/.*color0:\s*\(.*\).*$/\1/p' | head -n 1)
export FG_COLOR=$(xrdb -query | sed -ne 's/.*color7:\s*\(.*\).*$/\1/p' | head -n 1)

envsubst < "$DIR/dunst-config.dev.h.template" > "$DIR/config.dev.h"
