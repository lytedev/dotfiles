{ config, pkgs, ... }: {
  fonts.fonts = with pkgs; [ iosevka ];
	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};
	environment = {
		systemPackages = with pkgs; [
			firefox-devedition-bin
			pavucontrol
			brightnessctl
		];
	};
}
