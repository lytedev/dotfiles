{ config, pkgs, ... }:
let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	fonts.fonts = with pkgs; [
		# helvetica # needed by zoom
	];
	users.users.daniel = {
		isNormalUser = true;
		extraGroups = [ "wheel" "docker" ];
		shell = pkgs.fish;
		home = "/home/daniel/.home";
		packages = with pkgs; [
			fortune # fun sayings
			steam # games
			pulsemixer # audio
			file # identify file types
			kitty # terminal emulator
			unstable.fzf # fuzzy finder
			dmenu # TODO: currently only using this for dmenu_path in `bin/launch`
			ranger # tui for file management
			pass # the standard unix password manager
			vulkan-tools # vkcube for making sure vulkan still works
			rustup
			clang
			pavucontrol # gui pulseaudio manager
			pamixer # tui pulseaudio manager
			strongswan # work vpn
			gnumake
			elixir
			postgresql # database
			htop # almost as good as bottom (btm)
			unzip # needed by a handful of other utilities
			autoconf automake # autotools
			weechat # irc
			python39Full # python 3.9
			jq # awk for json
			xfce.thunar xfce.thunar-archive-plugin xfce.thunar-volman # gui file manager
			mpd # music player daemon
			ncmpcpp # ncurses music player client
			vlc # video player
			google-chrome # sometimes ya gotta screenshare

			# TODO: work module?
			google-cloud-sdk # gcloud
			kubectl # kubernetes cli
			awscli # aws cli
			zoom-us # video conferencing
			lastpass-cli

			# TODO: move this one to just laptop?
			brightnessctl # laptop screen brightness

			# nix utils
			nox # package querying and installation?
			# yay is to pacman, nox is to nix-env
			niv # dependency pinning?
			lorri # project envrc - like asdf-vm?
		];
	};
}
