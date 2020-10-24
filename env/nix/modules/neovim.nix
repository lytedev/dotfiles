{ config, pkgs, ... }: {
	environment.systemPackages = [ pkgs.neovim ];
}
