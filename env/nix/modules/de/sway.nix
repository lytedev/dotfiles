{ config, pkgs, ... }: {
	imports = [ ./base.nix ];
  programs.sway = {
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
    ];
  };
	# services.xserver.displayManager.defaultSession = "sway-lytedev";
}
