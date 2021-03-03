{ config, pkgs, ... }: {
	services.xserver.videoDrivers = [ "intel" ];
	nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
		};
	};
	hardware = {
		cpu.intel.updateMicrocode = true;
		opengl = {
			extraPackages = with pkgs; [
				vaapiIntel
				vaapiVdpau
				libvdpau-va-gl
			];
		};
	};
}
