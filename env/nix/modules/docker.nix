{ config, pkgs, ... }: {
	virtualisation.docker = {
		enable = true;
		enableOnBoot = false;
	};
	environment.systemPackages = with pkgs; [
		docker docker-compose
	];
}
