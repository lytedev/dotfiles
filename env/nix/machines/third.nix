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
		../modules/de/gnome.nix
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

	console.useXkbConfig = true;
	services.xserver.xkbOptions = "ctrl:nocaps";
		# TODO: setup caps-lock as Control/Escape?
	# console.font = "TER16x32";

	swapDevices = [ { device = "/swapfile"; size = (1024*16); } ];

	boot = {
		# fallocate -l 16G /swapfile
		resumeDevice = "/dev/disk/by-uuid/d1d92974-c0c0-4566-8131-c3dda9b21122";
		# sudo filefrag -v /swapfile | head -n 4 | tail -n 1 | \
		#	 tr -s "[:blank:]" | field 5 | tr -d ":"
		kernelParams = [ "resume_offset=874496" ];
	};

	# services.upower = {
	#		enable = true;
	#		criticalPowerAction = "Hibernate";
	# };
}
