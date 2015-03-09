#!/usr/bin/env bash

# You'll want to have neovim (nvim) installed first!

# Get source directory
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)

# We need to do some super quick setup for neovim plugins
echo "Setting up neovim plugins"
mkdir -p $HOME/.nvim
if [ -d "$HOME/.nvim/bundle/Vundle.vim" ]; then
    echo "Vundle already setup"
else
    git clone https://github.com/gmarik/Vundle.vim.git ~/.nvim/bundle/Vundle.vim
fi

echo "Installing vim plugins"
nvim +PluginInstall +qall

echo "Creating symlinks"

# Link files
rm -r $HOME/.config/luakit
rm -r $HOME/.zshrc
rm -r $HOME/.bashrc
rm -r $HOME/.vimrc
rm -r $HOME/.tmux.conf
rm -r $HOME/.irssi
rm -r $HOME/.muttrc
rm -r $HOME/.nvimrc
ln -s $DIR/apps/luakit $HOME/.config/luakit
ln -s $DIR/shell/zshrc $HOME/.zshrc
ln -s $DIR/shell/bashrc $HOME/.bashrc
ln -s $DIR/apps/nvim/nvimrc $HOME/.vimrc
ln -s $DIR/apps/nvim/nvimrc $HOME/.nvimrc
ln -s $DIR/shell/tmux.conf $HOME/.tmux.conf
ln -s $DIR/apps/irssi $HOME/.irssi
ln -s $DIR/apps/mutt/muttrc $HOME/.muttrc

