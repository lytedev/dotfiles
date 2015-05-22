#!/usr/bin/env bash

# Get source directory
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)

# Let user know that this script will delete their current configuration and
# that they should read this script before running. We'll use a lock file so
# the user only needs to agree once.
if [ -f "$DIR/scripts/agree_to_bootstrap.lock" ]; then
    # User agreed already - do nothing
    echo "Already agreed - continuing..."
else 
    echo "Running this script may delete existing personal configuration files."
    echo "Please view this script's source and backup any files before continuing."
    read -r -p "Are you sure you want to continue? [y/N] " response
    response=${response,,} # to_lower
    if [[ $response =~ ^(yes|y)$ ]]; then
        touch "$DIR/scripts/agree_to_bootstrap.lock"
    else
        exit 1
    fi
fi

echo "Creating symlinks"

# Link files
rm -rf $HOME/.config/luakit
rm -rf $HOME/.bashrc
rm -rf $HOME/.bash_profile
rm -rf $HOME/.vimrc
rm -rf $HOME/.tmux.conf
# rm -rf $HOME/.irssi
rm -rf $HOME/.newsbeuter
rm -rf $HOME/.weechat
rm -rf $HOME/.muttrc
rm -rf $HOME/.nvimrc
rm -rf $HOME/.config/bar
rm -rf $HOME/.gitconfig
rm -rf $HOME/.nvim
rm -rf $HOME/.vim
rm -rf $HOME/.gnupg/gpg.conf
ln -s $DIR/apps/luakit $HOME/.config/luakit
ln -s $DIR/shell/bashrc $HOME/.bashrc
ln -s $DIR/shell/bash_profile $HOME/.bash_profile
ln -s $DIR/apps/nvim/nvimrc $HOME/.vimrc
ln -s $DIR/apps/nvim/nvimrc $HOME/.nvimrc
ln -s $DIR/shell/tmux.conf $HOME/.tmux.conf
# ln -s $DIR/apps/irssi $HOME/.irssi
ln -s $DIR/apps/newsbeuter $HOME/.newsbeuter
ln -s $DIR/apps/weechat $HOME/.weechat
ln -s $DIR/apps/mutt/muttrc $HOME/.muttrc
ln -s $DIR/wm/bar $HOME/.config/bar
ln -s $DIR/shell/gitconfig $HOME/.gitconfig
ln -s $DIR/apps/nvim/nvim $HOME/.vim
ln -s $DIR/apps/nvim/nvim $HOME/.nvim
ln -s $DIR/gpg/gpg.conf $HOME/.gnupg/gpg.conf

# Sublime config location varies by OS
if [ "Darwin" = "$(uname -s)" ]; then
    # Assume OSX
    rm -rf "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
    ln -s "$DIR/apps/sublime_text/user_package" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
else
    # Assume Linux
    rm -rf "$HOME/.config/sublime-text-3/Packages/User"
    mkdir -p "$HOME/.config/sublime-text-3/Packages"
    ln -s "$DIR/apps/sublime_text/user_package" "$HOME/.config/sublime-text-3/Packages/User"
fi 

# We need to do some super quick setup for neovim plugins
echo "Installing vim plugins"
vim +PlugInstall +qall

if [ -f "$HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_client_support.so" ]; then 
    echo "YouCompleteMe is installed."
else
    echo "Installing YouCompleteMe..."
    $CUR_PWD="$(pwd)"
    cd "$HOME/.vim/bundle/YouCompleteMe"
    "./install.sh"
    cd "$CUR_PWD"
fi

echo "Adding DOTFILES_PATH to .bashrc"
sed -i "/export DOTFILES_PATH/c export DOTFILES_PATH=\"$DIR\"" "$HOME/.bashrc"

echo "You should now re-source your .bashrc, logout, or reboot."

