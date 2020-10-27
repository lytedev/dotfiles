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

	environment = {
		systemPackages = with pkgs; [ ntfs3g ];
	};

	fileSystems."/storage/ext".options = [ "defaults" "user" "nofail" ];
	fileSystems."/storage/butter".options = [ "defaults" "auto" "nofail" ];
	fileSystems."/storage/windows" = {
		device = "/dev/disk/by-uuid/AE624593624560E7";
		fsType = "ntfs";
		options = [ "defaults" "auto" "nofail" ];
	};
	fileSystems."/storage/shared" = {
		device = "/dev/disk/by-uuid/26F6144A6B518523";
		fsType = "ntfs";
		options = [ "defaults" "auto" "nofail" ];
	};
}
