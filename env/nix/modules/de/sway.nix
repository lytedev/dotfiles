{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	imports = [ ./base.nix ];
	programs = {
		sway = {
			enable = true;
			extraPackages = with pkgs; [
				swaylock
				swayidle
				xwayland
				waybar
				mako
				kanshi
				wl-clipboard
				slurp
				grim
				font-awesome
				unstable.gammastep
			];
			extraSessionCommands = ''
				export WLC_REPEAT_DELAY=200
				export WLC_REPEAT_RATE=60
				export CLUTTER_BACKEND=wayland
				export SDL_VIDEODRIVER=wayland
				export MOZ_ENABLE_WAYLAND=1
				export XDG_SESSION_TYPE=wayland
				export XDG_CURRENT_DESKTOP=sway
			'';
		};
		waybar.enable = true;
	};
	services = {
		pipewire.enable = true;
		xserver.libinput = {
			enable = true;
			tapping = true;
			naturalScrolling = true;
			disableWhileTyping = false;
		};
	};
  xdg.portal = {
    enable = true;
    gtkUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
}
