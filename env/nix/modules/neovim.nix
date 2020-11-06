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
			# we have to escape these doublequotes so that they work when NixOS
			# injects them into the shell
			MANPAGER = ''env MANWIDTH=\"\" nvim --cmd \"let g:prosession_on_startup=0\" +Man!'';
			MANWIDTH = "80";
		};
		shellAliases = aliases;
	};
	programs.bash.shellAliases = aliases;
	programs.fish.shellAliases = aliases;
}
