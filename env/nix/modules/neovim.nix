{ config, pkgs, ... }:
let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
	aliases = { vim = "nvim"; vi = "nvim"; };
in
{
	environment = {
		systemPackages = [ unstable.neovim ];
		variables = {
			EDITOR = "nvim";
			PAGER = "nvim";
			VISUAL = "nvim";
			MANPAGER = "nvim +Man!";
			MANWIDTH = "80";
		};
		shellAliases = aliases;
	};
	programs.bash.shellAliases = aliases;
	programs.fish.shellAliases = aliases;
}
