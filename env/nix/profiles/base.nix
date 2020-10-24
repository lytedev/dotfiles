{ config, pkgs, ... }: {
	imports = [
		../modules/fish.nix
		../modules/bash.nix
		../modules/tmux.nix
		../modules/neovim.nix
	];
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
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
		];
		variables = {
			PAGER = "less";
			VISUAL = "less";
		};
	};

  programs = {
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryFlavor = "curses";
		};
	};

  services = {
		openssh.enable = true;
	};
}
