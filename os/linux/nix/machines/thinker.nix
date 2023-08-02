# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, ... }:

let
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

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let 
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS="${datadir}:$XDG_DATA_DIRS
      gnome_schema = org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Catppuccin-Mocha'
    '';
  };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./thinker-hardware.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  networking.hostName = "thinker"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.daniel = {
    isNormalUser = true;
    home = "/home/daniel/.home";
    extraGroups = [ "wheel" ];
    packages = [];
  };

  services.dbus.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # TODO: my font?
  # TODO: wayland screensharing
  # TODO: wireplumber?
  environment.systemPackages = with pkgs; [
    age
    bat
    bind
    bottom
    brightnessctl
    broot
    curl
    delta
    dog
    dtach
    dua
    exa
    fd
    feh
    firefox
    fwupd
    gimp
    git
    git-lfs
    grim
    helix
    hexyl
    htop
    inkscape
    iputils
    kitty
    krita
    libinput
    libinput-gestures
    mako
    mosh
    nmap
    nnn
    noto-fonts
    pamixer
    pavucontrol
    playerctl
    pulsemixer
    rclone
    restic
    ripgrep
    rsync
    sd
    skim
    slurp
    sops
    swaybg
    swayidle
    swaylock
    traceroute
    unzip
    vlc
    watchexec
    waybar
    wget
    wireplumber
    wl-clipboard
    wofi
    xh
    zathura
  ];

  programs.thunar.enable = true;

  services.tailscale = {
    enable = true;
  };

  environment.variables = {
    EDITOR = "hx";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
    listenAddresses = [
      { addr = "0.0.0.0"; port = 22; }
    ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

