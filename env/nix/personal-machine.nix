{ config, pkgs, ... }:

{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
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
			wget vim neovim git curl fish bash tmux pciutils usbutils w3m networkmanager sway zsh kitty firefox-devedition-bin ripgrep lightdm fortune sd fzf dmenu ranger nodejs python3 rsync pass brightnessctl wl-clipboard waybar mako vulkan-tools htop rustup clang
		];
		variables = {
			EDITOR = "nvim";
		};
	};

  fonts.fonts = with pkgs; [ iosevka ];

  hardware = {
		pulseaudio = {
			enable = true;
			support32Bit = true;
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
		xserver = {
			enable = true;
			displayManager.lightdm = {
				enable = true;
			};
		};
	};

  networking.firewall.enable = false;

  sound.enable = true;

  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
		home = "/home/daniel/.home";
  };

  system.stateVersion = "20.03";
}
