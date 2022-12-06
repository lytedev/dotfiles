{ config, pkgs, ... }: {
	# services.xserver.displayManager.defaultSession
	services.xserver = {
		enable = true;
		displayManager.lightdm = {
			enable = true;
			greeter = {
				enable = true;
			};
			greeters.gtk = {
				enable = true;
				theme = {
					package = pkgs.arc-theme;
					name = "Arc-Dark";
				};
				clock-format = "%H:%M:%S";
				extraConfig = ''
					font-name=IosevkaLyteTerm Nerd Font Complete
				'';
			};
			# background = "";
		};
	};
	environment.systemPackages = with pkgs; [ lightdm lightdm_gtk_greeter ];
}
