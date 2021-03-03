{ config, pkgs, ... }: {
	hardware = {
		cpu.amd.updateMicrocode = true;
	};
}
