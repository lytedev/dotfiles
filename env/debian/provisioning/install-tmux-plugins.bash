#!/usr/bin/env bash

mkdir -p "$HOME/.config/systemd/user"

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"

# load tmux config
tmux source-file "$HOME/.tmux.conf"

# clean, install, and update plugins
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/clean_plugins"
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/install_plugins"
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/update_plugins"

# load tmux config
tmux source-file "$HOME/.tmux.conf"

systemctl --user enable tmux.service
systemctl --user restart tmux.service
