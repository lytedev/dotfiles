{ config, pkgs, ... }: {
	environment = {
		systemPackages = [ pkgs.neovim ];
		variables = {
			EDITOR = "nvim";
		};
		shellAliases = {
			vim = "neovim";
			vi = "neovim";
		};
	};
}
