{ config, pkgs, ... }: {
	imports = [
		../profiles/laptop.nix
		../modules/systemd-boot-efi.nix
		../modules/intel.nix
		../modules/docker.nix
		../modules/network-manager.nix
		../modules/bluetooth.nix
		../modules/pulseaudio.nix
		../modules/de/sway.nix
		../modules/users/daniel.nix
		../modules/users/valerie.nix
	];

	networking = {
		hostName = "third.lyte.dev";
		firewall.enable = false;
		networkmanager.wifi.powersave = true;
	};

	services.fwupd = {
		enable = true;
	};

	console.font = "TER16x32";

	# services.upower = {
	#		enable = true;
	#		criticalPowerAction = "Hibernate";
	# };
}
