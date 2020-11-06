{ config, pkgs, ... }: {
	environment.systemPackages = [ pkgs.bash ];
}
