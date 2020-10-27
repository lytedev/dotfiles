{ config, pkgs, ... }:

let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	programs.fish = {
		enable = true;
	};
	environment.systemPackages = [ unstable.fish ];
}

