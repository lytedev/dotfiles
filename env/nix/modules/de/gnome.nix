{ config, pkgs, ... }:

let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	imports = [ ./graphics.nix ];
	programs = {
	};
	services = {
		pipewire.enable = true;
		xserver = {
			desktopManager.gnome3.enable = true;
			libinput = {
				enable = true;
				tapping = true;
				naturalScrolling = true;
				disableWhileTyping = false;
			};
		};
		gnome3 = {
			gnome-keyring.enable = true;
			sushi.enable = true;
		};
	};
	systemd.packages = with pkgs.gnome3; [ gnome-session gnome-shell];
	environment.systemPackages = with pkgs.gnome3; [ adwaita-icon-theme ];
}
