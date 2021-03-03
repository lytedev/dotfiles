{ config, pkgs, ... }: {
	hardware.pulseaudio = {
		enable = true;
		support32Bit = true;
		package = pkgs.pulseaudioFull;
	};
	nixpkgs.config.pulseaudio = true;
	sound.enable = true;
}
