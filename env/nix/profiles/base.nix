{ config, pkgs, ... }: {
	imports = [
		../modules/fish.nix
		../modules/bash.nix
		../modules/tmux.nix
		../modules/neovim.nix
	];

	nixpkgs.config.allowUnfree = true;

	i18n.defaultLocale = "en_US.UTF-8";
	time.timeZone = "America/Chicago";

	environment = {
		systemPackages = with pkgs; [
			less
			wget curl
			rsync
			w3m
			git
			pciutils usbutils binutils
			ripgrep sd fd
			unzip
			killall
		];
	};

	programs = {
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryFlavor = "curses";
		};
	};

	services = {
		openssh = {
			enable = true;
			passwordAuthentication = false;
			permitRootLogin = "no";
		};
	};

	console = {
		earlySetup = true;
		colors = [
			"111111"
			"f92672"
			"a6e22e"
			"f4bf75"
			"66d9ef"
			"ae81ff"
			"a1efe4"
			"f8f8f2"
			"75715e"
			"f92672"
			"a6e22e"
			"f4bf75"
			"66d9ef"
			"ae81ff"
			"a1efe4"
			"f9f8f5"
		];
	};
}
