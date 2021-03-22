#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "$XDG_CONFIG_HOME/systemd/user"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ] && \
	git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"

echo "Reloading tmux config..."
tmux source-file "$HOME/.tmux.conf" &>/dev/null

echo "Installing tmux plugins..."
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/clean_plugins" &>/dev/null
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/install_plugins" &>/dev/null
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/update_plugins" &>/dev/null

echo "Finalizing tmux plugin installation..."
tmux source-file "$HOME/.tmux.conf" &>/dev/null
