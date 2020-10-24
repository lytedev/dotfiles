{ config, pkgs, ... }: {
  hardware.pulseaudio = {
		enable = true;
		support32Bit = true;
		package = pkgs.pulseaudioFull;
	};
  sound.enable = true;
}
