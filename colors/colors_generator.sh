#!/usr/bin/env bash

opdir="$HOME/.config/base16-builder/output"

echo "Clearing existing base16-builder output"
rm -rf "$opdir"
mkdir -p "$opdir"

# create color scheme files
~/.config/base16-builder/base16 -s "$DOTFILES_PATH/colors/current.yml"

cp "$(ls $opdir/vim/*.vim | head -n 1)" "$DOTFILES_PATH/colors/current.vim"
rm -f "$DOTFILES_PATH/apps/nvim/nvim/colors/current.vim"
ln -s "$DOTFILES_PATH/colors/current.vim" "$DOTFILES_PATH/apps/nvim/nvim/colors/current.vim"

cp "$(ls $opdir/xresources/*.dark.xresources | head -n 1)" "$DOTFILES_PATH/colors/current.dark.xresources"
cp "$(ls $opdir/xresources/*.light.xresources | head -n 1)" "$DOTFILES_PATH/colors/current.light.xresources"
rm -f "$HOME/.Xresources.colors"
rm -f "$DOTFILES_PATH/wm/xorg/.Xresources.colors"
ln -s "$DOTFILES_PATH/colors/current.dark.xresources" "$HOME/.Xresources.colors"
ln -s "$DOTFILES_PATH/colors/current.dark.xresources" "$DOTFILES_PATH/wm/xorg/.Xresources.colors"

cp "$(ls $opdir/iterm2/*.dark.itermcolors | head -n 1)" "$DOTFILES_PATH/colors/current.dark.itermcolors"
cp "$(ls $opdir/iterm2/*.light.itermcolors | head -n 1)" "$DOTFILES_PATH/colors/current.light.itermcolors"

cp "$(ls $opdir/shell/*.dark.sh | head -n 1)" "$DOTFILES_PATH/colors/current.dark.sh"
cp "$(ls $opdir/shell/*.light.sh | head -n 1)" "$DOTFILES_PATH/colors/current.light.sh"

xrdb ~/.Xresources
source "$DOTFILES_PATH/colors/current.dark.sh"
source "$DOTFILES_PATH/wm/bspwmrc"
