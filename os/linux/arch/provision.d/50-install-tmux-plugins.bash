#!/usr/bin/env bash

mkdir -p "$XDG_CONFIG_HOME/systemd/user"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ] && \
	git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"

tmux source-file "$HOME/.tmux.conf"

bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/clean_plugins"
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/install_plugins"
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/update_plugins"

tmux source-file "$HOME/.tmux.conf"
