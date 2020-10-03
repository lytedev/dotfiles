# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
		# TODO: fork?
    (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
	];

	home-manager.users.daniel = {
	}

	# TODO: bootloader will vary by device
	boot = {
		supportedFilesystems = [ "exfat" ];
		loader = {
			grub = {
				enable = true;
				version = 2;
				device = "/dev/sda";
			};
		};
	};

	networking = {
		hostName = "nether";
		useDHCP = true;
		firewall = {
			allowedTCPPorts = [ 22 80 443 7770 ];
			allowedUDPPorts = [ 53 57 63 67 7770 ];
			# enable = false;
		};
	};

	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

	time.timeZone = "America/Chicago";

	environment = {
		systemPackages = with pkgs; [
			wget lsof vim git curl fish fzf neovim
		];
		variables.EDITOR = "nvim";
	};

	services = {
		openssh.enable = true;

		xserver = {
			enable = true;
			layout = "us";
			libinput.enable = true;
			desktopManager.plasma5.enable = true;
		};
	};

	fonts = {
		enableFontDir = true;
		enableGhostscriptFonts = true;

		fontconfig = {
			enable = true;
			antialias = true;
			useEmbeddedBitmaps = true;

			defaultFonts = {
				serif = [ "Iosevka Type" ];
				sansSerif = [ "Iosevka Type" ];
				monospace = [ "Iosevka Type" ];
			};
		};

		fonts = with pkgs; [
			iosevka
			nerdfonts
		];
	};

	sound.enable = true;
	hardware.pulseaudio.enable = true;

	users.extraUsers.daniel = {
		isNormalUser = true;
		group = "users";
		extraGroups = [ "wheel" ];
		home = "/home/daniel/.home";
		shell = pkgs.fish;
		createHome = true;
		uid = 1000;
	};

	nixpkgs.config = {
		allowUnfree = true;
	};

	system.stateVersion = "20.03";
}
