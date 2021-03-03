{ config, pkgs, ... }: {
	imports = [ ../gdm.nix ];
	fonts.fonts = with pkgs; [ iosevka ];
	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};
	environment = {
		systemPackages = with pkgs; [
			glxinfo
			firefox-devedition-bin
			pavucontrol
			brightnessctl
		];
	};
	qt5 = {
		platformTheme = "gtk2";
		style = "gtk2";
	};
}
