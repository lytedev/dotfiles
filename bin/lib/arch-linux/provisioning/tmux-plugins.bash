#!/usr/bin/env bash

mkdir -p "$HOME/.config/systemd/user"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ] && \
	git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"

tmux source-file "$HOME/.tmux.conf"

bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/clean_plugins"
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/install_plugins"
bash "$XDG_CONFIG_HOME/tmux/plugins/tpm/bindings/update_plugins"

tmux source-file "$HOME/.tmux.conf"

systemctl --user enable tmux.service
systemctl --user restart tmux.service
