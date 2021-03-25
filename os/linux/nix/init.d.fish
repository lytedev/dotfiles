symlink_nixos_config() {
	rm --force "/etc/nixos/lytedev"
	ln --symbolic "$1" "/etc/nixos/lytedev"
}

