{ config, pkgs, ... }: {
	# services.xserver.displayManager.defaultSession
	services.xserver = {
		enable = true;
		displayManager = {
			gdm = {
				enable = true;
				wayland = true;
			};
		};
	};
}
