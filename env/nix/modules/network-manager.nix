{ config, pkgs, ... }: {
	networking.networkmanager.enable = true;
	environment.systemPackages = [ pkgs.networkmanager ];
}
