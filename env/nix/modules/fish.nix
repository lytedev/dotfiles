{ config, pkgs, ... }: {
	environment.systemPackages = [ pkgs.fish ];
  programs.fish.enable = true;
}

