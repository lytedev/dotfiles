{ config, pkgs, ... }:

{
	nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
		};
	};
}
