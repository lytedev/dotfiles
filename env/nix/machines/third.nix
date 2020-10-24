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

  networking.hostName = "third.lyte.dev";
  networking.firewall.enable = false;
}
