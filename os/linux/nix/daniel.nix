{ pkgs, ... }: {
  home.username = "daniel";
  home.homeDirectory = "/home/daniel/.home";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
  }
}