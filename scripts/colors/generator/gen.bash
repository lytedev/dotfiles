#!/usr/bin/env bash

SCHEME="donokai"
TYPE="dark"

# v=$(ruby --version)

if [[ $? -eq 0 ]]; then
	if [[ -n $1 ]]; then SCHEME=$1; fi
	if [[ -n $2 ]]; then TYPE=$2; fi

	DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)

	mkdir -p "$DIR/vendor"

	B16_DIR="$DIR/vendor/base16-builder"
	COLORS_PATH="$B16_DIR/output"

	if [ -d "$B16_DIR" ]; then
		echo "Skipping repo pull down..."
		rm -rf "$COLORS_PATH"
		mkdir -p "$COLORS_PATH"
	else
		git clone https://github.com/lytedev/base16-builder.git "$DIR/vendor/base16-builder"
	fi

	"$DIR/vendor/base16-builder/base16" -t vim -s "$DIR/schemes/$SCHEME.yml"
	"$DIR/vendor/base16-builder/base16" -t vconsole -s "$DIR/schemes/$SCHEME.yml"
	"$DIR/vendor/base16-builder/base16" -t xresources -s "$DIR/schemes/$SCHEME.yml"
	"$DIR/vendor/base16-builder/base16" -t shell -s "$DIR/schemes/$SCHEME.yml"

	# replace existing color files
	rm -f "$DIR/../shell"
	rm -f "$DIR/../vconsole"
	rm -f "$DIR/../vim"
	rm -f "$DIR/../xresources"
	cp "$COLORS_PATH/xresources/base16-$SCHEME.$TYPE.xresources" "$DIR/../xresources"
	cp "$COLORS_PATH/vconsole/base16-$SCHEME.$TYPE.sh" "$DIR/../vconsole"
	cp "$COLORS_PATH/vim/base16-$SCHEME.vim" "$DIR/../vim"
	cp "$COLORS_PATH/shell/base16-$SCHEME.$TYPE.sh" "$DIR/../shell"
	chmod +x "$DIR/../shell"
	chmod +x "$DIR/../vconsole"

	echo "Colors have been regenerated. You will need to re-link them."
else
	echo "Ruby isn't installed."
fi
