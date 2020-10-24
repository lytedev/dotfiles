{ config, pkgs, ... }: {
	environment = {
		systemPackages = [ pkgs.neovim ];
		variables = {
			EDITOR = "nvim";
			MANPAGER = "nvim +Man!";
			MANWIDTH = "80";
		};
		shellAliases = {
			vim = "nvim";
			vi = "nvim";
		};
	};
}
