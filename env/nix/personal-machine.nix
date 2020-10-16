{ config, pkgs, ... }:

{
  imports = [ /etc/nixos/hardware-configuration.nix ];

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};

	nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
		};
	};

  networking = {
    networkmanager.enable = true;
    hostName = "third.lyte.dev";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  time.timeZone = "America/Chicago";

	environment = {
		systemPackages = with pkgs; [
			fish bash tmux
			vim neovim
			networkmanager
			wget curl w3m
			git
			pciutils usbutils binutils
			ripgrep sd
			nodejs python3
			rsync
		];
		variables = {
			EDITOR = "nvim";
		};
	};

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
		];
  };

  system.stateVersion = "20.03";
}
