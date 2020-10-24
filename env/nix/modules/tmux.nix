{ config, pkgs, ... }: {
	environment.systemPackages = [ pkgs.tmux ];
}

