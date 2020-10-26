#!/usr/bin/env sh

# NOTE: run this from inside a NixOS installation, not from the live USB/CD

rhome="/root"
home="/home/daniel/.home"
nhome="/home/daniel"
cfd="/.config/dotfiles"

add_unstable_channel() {
	nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
	nix-channel --update
}

clone_dotfiles() {
	echo "Setting up dotfiles for root..."
	mkdir --parents "$1"
	git clone "https://git.lyte.dev/lytedev/dotfiles" "$1"
}

symlink_nixos() {
	rm --force "/etc/nixos/lytedev"
	ln --symbolic "$1" "/etc/nixos/lytedev"
}

setup_wallpaper() {
	mkdir --parents "$nhome/img/walls"
	curl --silent --output "$nhome/img/walls/clouds_by_souredapply.png" \
		"https://art.ngfiles.com/images/530000/530895_souredapple_clouds.png"
	rm --recursive --force "$home/.wallpaper"
	ln --symbolic "$nhome/img/walls/clouds_by_souredapply.png" "$home/.wallpaper"
}

generate_ssh_key() {
	mkdir --mode 600 --parents "$home/.ssh"
	ssh-keygen -N '' -t ed25519 -f "$home/.ssh/$(hostname --short)"
	mkdir --mode 640 --parents "$nhome/public"
	cp "$home/.ssh/$(hostname --short).pub" "$nhome/public"
}

fix_dotfiles_origin() {
	cd "$home$cfd"
	git remote set-url origin "ssh://git@git.lyte.dev:2222/lytedev/dotfiles.git"
}

init_for_root() {
	clone_dotfiles "$rhome$cfd"
	symlink_nixos "$rhome$cfd/env/nix/"
	add_unstable_channel
	nixos-rebuild switch
	chown daniel:users "$home"
	echo "Re-running as user daniel..."
	sudo --user daniel "$rhome$cfd/init.sh"
}

init_for_daniel() {
	clone_dotfiles "$home$cfd"
	generate_ssh_key
	symlink_nixos "$home$cfd/env/nix/"
	setup_wallpaper
	# TODO: setup ssh/gpg keys
	# TODO: setup password store
	fix_dotfiles_origin
}

if [ "$EUID" -eq 0 ]
	init_for_root
else
	init_for_daniel
fi

echo "Here is this machine's public SSH key:"
echo "  $(cat "$home/.ssh/$(hostname --short).pub")"
echo "It needs to be added to existing cloud-based git accounts"
echo "and other machines before proceeding."
echo
echo "Don't forget to setup GPG keys by importing from an existing machine"
echo "or adding new child keys!"
echo
echo "The simplest method for doing this is to run the following:"
echo '  scp -r "$TARGET_MACHINE:~/.gnupg" "$HOME/.gnupg"
