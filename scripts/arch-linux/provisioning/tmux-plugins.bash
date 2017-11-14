#!/usr/bin/env bash

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# load tmux config
tmux source "$HOME/.tmux.conf"

# clean, install, and update plugins
bash "$HOME/.tmux/plugins/tpm/bindings/clean_plugins"
bash "$HOME/.tmux/plugins/tpm/bindings/install_plugins"
bash "$HOME/.tmux/plugins/tpm/bindings/update_plugins"
