#!/usr/bin/env bash

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
tmux source "$HOME/.tmux.conf"
bash "$HOME/.tmux/plugins/tpm/bindings/clean_plugins"
bash "$HOME/.tmux/plugins/tpm/bindings/install_plugins"
bash "$HOME/.tmux/plugins/tpm/bindings/update_plugins"
