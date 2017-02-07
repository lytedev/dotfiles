#!/usr/bin/env bash

v=$(ruby --version)

if [[ $? -eq 0 ]]; then
	SCHEME="donokai"
	if [[ -n $1 ]]; then
		SCHEME=$1
	fi

	DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
	source "$DIR/variables.bash"

	mkdir -p "$DOTFILES_PATH/colors/gen/vendor"

	B16_DIR="$DOTFILES_PATH/colors/gen/vendor/base16-builder"
	COLORS_PATH="$B16_DIR/output"

	if [ -d "$B16_DIR" ]; then
		echo "Skipping repo pull down..."
		rm -rf "$COLORS_PATH"
		mkdir -p "$COLORS_PATH"
	else
		git clone https://github.com/lytedev/base16-builder.git "$DOTFILES_PATH/colors/gen/vendor/base16-builder"
	fi

	"$DOTFILES_PATH/colors/gen/vendor/base16-builder/base16" -t vim -s "$DOTFILES_PATH/colors/gen/schemes/$SCHEME.yml"
	"$DOTFILES_PATH/colors/gen/vendor/base16-builder/base16" -t xresources -s "$DOTFILES_PATH/colors/gen/schemes/$SCHEME.yml"
	"$DOTFILES_PATH/colors/gen/vendor/base16-builder/base16" -t shell -s "$DOTFILES_PATH/colors/gen/schemes/$SCHEME.yml"

	COLORS_PATH=$DOTFILES_PATH/colors/gen/vendor/base16-builder/output

	rm -f "$DOTFILES_PATH/colors/xresources"
	rm -f "$DOTFILES_PATH/colors/vim"
	rm -f "$DOTFILES_PATH/colors/shell"
	cp "$COLORS_PATH/xresources/base16-$SCHEME.dark.xresources" "$DOTFILES_PATH/colors/xresources"
	cp "$COLORS_PATH/vim/base16-$SCHEME.vim" "$DOTFILES_PATH/colors/vim"
	cp "$COLORS_PATH/shell/base16-$SCHEME.dark.sh" "$DOTFILES_PATH/colors/shell"
	chmod +x "$DOTFILES_PATH/colors/shell"

	xrdb -merge "$DOTFILES_PATH/colors/xresources"
	source "$DOTFILES_PATH/scripts/reload_xresources.sh"
	source "$DOTFILES_PATH/env/wm/bspwm_config" > /dev/null
	# kill -SIGUSR1 $(cat "$BAR_PID_FILE")
else
	echo "Ruby isn't installed."
fi
