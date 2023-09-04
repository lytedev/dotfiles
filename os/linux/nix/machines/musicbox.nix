# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, inputs, ... }:

let
  # this is unused because it's referenced by my sway config
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # this is unused because it's referenced by my sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS="${datadir}:$XDG_DATA_DIRS
        gnome_schema = org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Catppuccin-Mocha'
      '';
  };
in
{
  # TODO: fonts? right now, I'm just installing to ~/.local/share/fonts

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub.devices = [ "/dev/sda" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };

  hardware.bluetooth.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    driSupport = true;

    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  networking.hostName = "musicbox";
  networking.networkmanager.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";

  hardware.pulseaudio.support32Bit = true;

  users.users.daniel = {
    isNormalUser = true;
    home = "/home/daniel/.home";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAPLXOjupz3ScYjgrF+ehrbp9OvGAWQLI6fplX6w9Ijb daniel@lyte.dev"
    ];
    extraGroups = [ "wheel" "video" ];
    packages = [ ];
  };

  services.dbus.enable = true;

  environment.systemPackages = with pkgs; [
    age
    bat
    bind
    bottom
    brightnessctl
    clang
    curl
    delta
    dog
    dtach
    dua
    exa
    fd
    feh
    file
    fwupd
    gcc
    gimp
    git
    git-lfs
    grim
    inputs.helix.packages."x86_64-linux".helix
    hexyl
    htop
    inkscape
    inotify-tools
    iputils
    killall
    kitty
    krita
    libinput
    libinput-gestures
    libnotify
    lutris
    gnumake
    mako
    mosh
    nmap
    nnn
    nil
    nixpkgs-fmt
    noto-fonts
    openssl
    pamixer
    pavucontrol
    pciutils
    pgcli
    playerctl
    podman-compose
    pulseaudio
    pulsemixer
    rclone
    restic
    ripgrep
    rsync
    sd
    slurp
    sops
    steam
    swaybg
    swayidle
    swaylock
    tmux
    traceroute
    unzip
    vlc
    vulkan-tools
    watchexec
    waybar
    wget
    wireplumber
    wine
    wl-clipboard
    wofi
    xh
    zathura
    zellij
    zstd
  ];

  services.pcscd.enable = true;
  services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    enableSSHSupport = true;
  };

  programs.thunar.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  environment.variables = {
    EDITOR = "hx";
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
    listenAddresses = [
      { addr = "0.0.0.0"; port = 22; }
    ];
  };

  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  system.stateVersion = "23.05";
}

