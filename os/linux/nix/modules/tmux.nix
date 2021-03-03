{ config, pkgs, ... }: {
	environment.systemPackages = [ pkgs.tmux ];
	programs.tmux = {
		enable = true;
	};
}

