{ pkgs, ... }: {
  home.username = "daniel";
  home.homeDirectory = "/home/daniel/.home";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.firefox = {
    enable = true;

    package = (pkgs.firefox.override { extraNativeMessagingHosts = [ pkgs.passff-host ]; });

    # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #   ublock-origin
    # ];

    profiles = {
      daniel = {
        id = 0;
        settings = {
          "general.smoothScroll" = true;
        };

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
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
  # };
}
