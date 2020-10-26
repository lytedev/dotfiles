{ config, pkgs, ... }: {
	imports = [
		../profiles/desktop.nix
		../modules/systemd-boot-efi.nix
		../modules/amd.nix
		../modules/amd-gpu.nix
		../modules/docker.nix
		../modules/network-manager.nix
		../modules/bluetooth.nix
		../modules/pulseaudio.nix
		../modules/de/sway.nix
		../modules/users/daniel.nix
		../modules/users/valerie.nix
	];

	networking = {
		hostName = "wallwart.lyte.dev";
		firewall.enable = false;
	};

	console.useXkbConfig = true;
	services.xserver.xkbOptions = "ctrl:nocaps";
}
