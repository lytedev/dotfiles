#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source "$DIR/variables.bash"

mkdir -p "$DOTFILES_PATH/colors/gen/vendor"

B16_DIR="$DOTFILES_PATH/colors/gen/vendor/base16-builder"
if [ -d "$B16_DIR" ]; then
  echo "Skipping repo pull down..."
else
  git clone https://github.com/lytedev/base16-builder.git "$DOTFILES_PATH/colors/gen/vendor/base16-builder"
fi

cd "$DOTFILES_PATH/colors/gen/schemes"
cp * "$DOTFILES_PATH/colors/gen/vendor/base16-builder/schemes"
cd -

"$DOTFILES_PATH/colors/gen/vendor/base16-builder/base16" -t vim
"$DOTFILES_PATH/colors/gen/vendor/base16-builder/base16" -t xresources
"$DOTFILES_PATH/colors/gen/vendor/base16-builder/base16" -t shell

COLORS_PATH=$DOTFILES_PATH/colors/gen/vendor/base16-builder/output
cp "$COLORS_PATH/xresources/base16-donokai.dark.xresources" "$DOTFILES_PATH/colors/xresources"
cp "$COLORS_PATH/vim/base16-donokai.vim" "$DOTFILES_PATH/colors/vim"
cp "$COLORS_PATH/shell/base16-donokai.dark.sh" "$DOTFILES_PATH/colors/shell"

