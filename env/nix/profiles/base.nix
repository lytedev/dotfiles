{ config, pkgs, ... }:

{
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
  time.timeZone = "America/Chicago";

	environment = {
		systemPackages = with pkgs; [
			fish bash
			tmux
			neovim
			networkmanager
			wget curl
			rsync
			w3m
			git
			pciutils usbutils binutils
			ripgrep sd fd
		];
		variables = {
			EDITOR = "nvim";
			PAGER = "nvim";
			VISUAL = "nvim";
		};
	};
}
