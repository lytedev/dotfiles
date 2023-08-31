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
  imports =
    [
      # Include the results of the hardware scan.
      ./thinker-hardware.nix
    ];

  # TODO: hibernation? I've been using [deep] in /sys/power/mem_sleep alright
  # with this machine so it may not be necessary?
  # need to measure percentage lost per day, but I think it's around 10%/day

  # TODO: fonts? right now, I'm just installing to ~/.local/share/fonts

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
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
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # pulse.support32Bit = true;
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
  # hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget

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

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "daniel" ];
    ensureUsers = [
      {
        name = "daniel";
        ensurePermissions = {
          "DATABASE daniel" = "ALL PRIVILEGES";
        };
      }
    ];
    enableTCPIP = true;

    package = pkgs.postgresql_15;

    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser    auth-method
      local all       postgres  peer map=superuser_map
      local all       daniel    peer map=superuser_map
      local sameuser  all       peer map=superuser_map

      # lan ipv4
      host  all       all     10.0.0.0/24   trust
      host  all       all     127.0.0.1/32  trust

      # tailnet ipv4
      host       all       all     100.64.0.0/10 trust
    '';

    identMap = ''
      # ArbitraryMapName systemUser DBUser
        superuser_map    root       postgres
        superuser_map    postgres   postgres
        superuser_map    daniel     postgres
        # Let other names login as themselves
        superuser_map   /^(.*)$    \1
    '';
  };


  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers = {
      backend = "podman";
    };
  };

  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

