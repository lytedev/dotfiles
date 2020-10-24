{ config, pkgs, ... }:

{
	imports = [
		../profiles/laptop.nix
		../modules/systemd-boot-efi.nix
		../modules/intel.nix
	];

  networking.hostName "third.lyte.dev";

  fonts.fonts = with pkgs; [ iosevka ];

  virtualisation.docker.enable = true;

  hardware = {
		bluetooth = {
			enable = true;
		};
		pulseaudio = {
			enable = true;
			support32Bit = true;
			package = pkgs.pulseaudioFull;
			# extraConfig = "
			# 	load-module module-switch-on-connect
			# ";
		};
		opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;
			extraPackages = with pkgs; [
				vaapiIntel
				vaapiVdpau
				libvdpau-va-gl
			];
		};
	};

  programs = {
		fish.enable = true;
		mtr.enable = true;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryFlavor = "curses";
		};
	};

  services = {
		openssh.enable = true;
	};

  networking.firewall.enable = false;

  sound.enable = true;

  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
		home = "/home/daniel/.home";
		packages = with pkgs; [
			steam
			pulsemixer
			file
			appimage-run
			kitty
			sway waybar mako wl-clipboard
			firefox-devedition-bin
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
			docker docker-compose
			postgresql
			htop
			google-cloud-sdk
			slurp grim
			unzip
			automake
			autoconf
			ncurses
		];
  };
}
