{ config, pkgs, ... }: {
	users.users.valerie = {
		isNormalUser = true;
		shell = pkgs.fish;
		home = "/home/valerie";
	};
}
