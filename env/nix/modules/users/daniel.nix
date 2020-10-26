{ config, pkgs, ... }: {
  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
		home = "/home/daniel/.home";
		packages = with pkgs; [
			fortune
			steam
			pulsemixer
			file
			appimage-run
			kitty
			fzf
			fortune
			dmenu
			ranger
			pass
			brightnessctl
			vulkan-tools # TODO: vulkan?
			rustup
			clang
			pavucontrol
			pamixer
			strongswan
			gnumake
			elixir
			postgresql
			htop
			google-cloud-sdk
			unzip
			automake
			autoconf
			ncurses
			weechat
			python39Full
			# thunar thunar-archive-plugin thunar-volman
		];
  };
}
