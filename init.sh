#!/usr/bin/env sh

# NOTE: run this from inside a NixOS installation, not from the live USB/CD

root_home="/root"
daniel_home="/home/daniel/.home"
nice_home="/home/daniel"
dotfiles="/.config/dotfiles"

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
	mkdir --parents "$nice_home/img/walls"
	curl --silent --output "$nice_home/img/walls/clouds_by_souredapply.png" \
		"https://art.ngfiles.com/images/530000/530895_souredapple_clouds.png"
	rm --recursive --force "$daniel_home/.wallpaper"
	ln --symbolic "$nice_home/img/walls/clouds_by_souredapply.png" "$daniel_home/.wallpaper"
}

generate_ssh_key() {
	mkdir --mode 600 --parents "$daniel_home/.ssh"
	keyfile="$daniel_home/.ssh/$(hostname --short)"
	ssh-keygen -N '' -t ed25519 -f "$keyfile"
	mkdir --mode 640 --parents "$nice_home/public"
	cp "$keyfile.pub" "$nice_home/public"
	ssh-add "$keyfile"
}

fix_dotfiles_origin() {
	cd "$daniel_home$dotfiles"
	git remote set-url origin "ssh://git@git.lyte.dev:2222/lytedev/dotfiles.git"
}

init_for_root() {
	clone_dotfiles "$root_home$dotfiles"
	symlink_nixos "$root_home$dotfiles/env/nix/"
	add_unstable_channel
	nixos-rebuild switch
	chown daniel:users "$daniel_home"
	echo "Re-running as user daniel..."
	sudo --user daniel "$root_home$dotfiles/init.sh"
}

init_for_daniel() {
	clone_dotfiles "$daniel_home$dotfiles"
	generate_ssh_key
	symlink_nixos "$daniel_home$dotfiles/env/nix/"
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
echo "  $(cat "$daniel_home/.ssh/$(hostname --short).pub")"
echo "It needs to be added to existing cloud-based git accounts"
echo "and other machines before proceeding."
echo
echo "Don't forget to setup GPG keys by importing from an existing machine"
echo "or adding new child keys!"
echo
echo "The simplest method for doing this is to run the following:"
echo '  scp -r "$TARGET_MACHINE:~/.gnupg" "$HOME/.gnupg"
