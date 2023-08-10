{ pkgs, ... }: {
  home.username = "daniel";
  home.homeDirectory = "/home/daniel/.home";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.nix-direnv.enable = true;

  programs.fish.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.pointerCursor = {
    name = "Catppuccin-Mocha-Sapphire-Cursors";
    package = pkgs.catppuccin-cursors.mochaSapphire;
    size = 64; # TODO: this doesn't seem to work -- at least in Sway
  };

  programs.firefox = {
    enable = true;

    package = (pkgs.firefox.override { extraNativeMessagingHosts = [ pkgs.passff-host ]; });

    # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #   ublock-origin
    # ]; # TODO: would be nice to have _all_ my firefox stuff managed here instead of Firefox Sync maybe?

    profiles = {
      daniel = {
        id = 0;
        settings = {
          "general.smoothScroll" = true;
        };

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          // user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
        '';

        userChrome = ''
          /* Remove close button*/ .titlebar-buttonbox-container{ display:none } 

          #webrtcIndicator {
          	display: none;
          }

          #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar>.toolbar-items {
          	opacity: 0;
          	pointer-events: none;
          }

          #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
          	visibility: collapse !important;
          } 
        '';

        # userContent = ''
        # '';
      };

    };
  };

  # wayland.windowManager.sway = {
  #   enable = true;
  # }; # TODO: would be nice to have my sway config declared here instead of symlinked in by dotfiles scripts?
  # maybe we can share somehow so things for nix-y systems and non-nix-y systems alike
}
