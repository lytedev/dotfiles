# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }: rec {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ./beefcake-hardware.nix
  ];

  services.api-lyte-dev = rec {
    enable = true;
    port = 5757;
    stateDir = "/var/lib/api-lyte-dev";
    configFile = sops.secrets."api.lyte.dev".path;
    user = "api-lyte-dev";
    group = user;
  };

  systemd.services.api-lyte-dev.environment.LOG_LEVEL = "debug";

  sops = {
    defaultSopsFile = ../secrets/beefcake/secrets.yml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      # example-key = {
      #   # see these and other options' documentation here:
      #   # https://github.com/Mic92/sops-nix#set-secret-permissionowner-and-allow-services-to-access-it

      #   # set permissions:
      #   # mode = "0440";
      #   # owner = config.users.users.nobody.name;
      #   # group = config.users.users.nobody.group;

      #   # restart service when a secret changes or is newly initialized
      #   # restartUnits = [ "home-assistant.service" ];

      #   # symlink to certain directories
      #   path = "/var/lib/my-example-key/secrets.yaml";

      #   # for use as a user password
      #   # neededForUsers = true;
      # };

      # subdirectory
      # "myservice/my_subdir/my_secret" = { };

      "api.lyte.dev" = {
        path = "${services.api-lyte-dev.stateDir}/secrets.json";
        # TODO: would be cool to assert that it's correctly-formatted JSON?
        mode = "0440";
        owner = services.api-lyte-dev.user;
        group = services.api-lyte-dev.group;
      };

      plausible-admin-password = { };
      plausible-erlang-cookie = { };
      plausible-secret-key-base = { };
    };
  };

  # TODO: non-root processes and services that access secrets need to be part of
  # the 'keys' group

  # systemd.services.some-service = {
  #   serviceConfig.SupplementaryGroups = [ config.users.groups.keys.name ];
  # };
  # or
  # users.users.example-user.extraGroups = [ config.users.groups.keys.name ];

  # TODO: directory attributes for /storage subdirectories?
  # example: user daniel should be able to write to /storage/files.lyte.dev and
  # caddy should be able to serve it

  # TODO: declarative directory quotas? for storage/$USER and /home/$USER

  # TODO: would be nice to get ALL the storage stuff declared in here
  # should I be using btrfs subvolumes? can I capture file ownership, perimssions, and ACLs?

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.tmpfiles.rules = [
    "d /var/spool/samba 1777 root root -"
  ];

  networking.hostName = "beefcake";

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.groups.daniel.members = [ "daniel" ];
  users.groups.nixadmin.members = [ "daniel" ];

  users.users.daniel = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAPLXOjupz3ScYjgrF+ehrbp9OvGAWQLI6fplX6w9Ijb daniel@lyte.dev"
    ];
    group = "daniel";
    extraGroups = [
      "nixadmin" # write access to /etc/nixos/ files
      "wheel" # sudo access
      "caddy" # write access to /storage/files.lyte.dev
      "users" # general users group
      "jellyfin" # write access to /storage/jellyfin
    ];
    # packages = with pkgs; [];
  };

  users.users.lytedev = {
    # for running my services and applications and stuff
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAPLXOjupz3ScYjgrF+ehrbp9OvGAWQLI6fplX6w9Ijb daniel@lyte.dev"
    ];
    group = "lytedev";
    extraGroups = [
    ];
  };

  users.users.ben = {
    isNormalUser = true;
    packages = with pkgs; [
      vim
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUfLZ+IX85p9355Po2zP1H2tAxiE0rE6IYb8Sf+eF9T ben@benhany.com"
    ];
  };

  users.users.alan = {
    isNormalUser = true;
    packages = with pkgs; [
      vim
    ];
    openssh.authorizedKeys.keys = [
      ""
    ];
  };

  users.users.restic = {
    # used for other machines to backup to
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbPqzKB09U+i4Kqu136yOjflLZ/J7pYsNulTAd4x903 root@chromebox.h.lyte.dev"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAPLXOjupz3ScYjgrF+ehrbp9OvGAWQLI6fplX6w9Ijb daniel@lyte.dev"
    ];
  };

  users.users.guest = {
    isSystemUser = true;
    group = "user";
    createHome = true;
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  environment.variables = {
    EDITOR = "hx";
  };

  # TODO: right now, I use a flake for helix that gets the latest since my config uses newer features
  # would be nice to get that declared here
  # I think this was done with `nix profile install github:helix-editor/helix --priority 0`?

  # search for packages: `nix search $PACKAGE_NAME`
  environment.systemPackages = with pkgs; [
    inputs.helix.packages."x86_64-linux".helix
    zellij
    mosh
    btrfs-progs
    iperf3
    pv
    linuxquota
    traceroute
    hexyl
    restic
    speedtest-cli
    fish
    restic
    nil
    nixpkgs-fmt
    fd
    ripgrep
    exa
    skim
    git
    wget
    tmux
    sqlite
  ];

  services.xserver.layout = "us";

  # TODO: make the client declarative? right now I think it's manually git
  # clone'd to /root
  systemd.services.deno-netlify-ddns-client = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ curl bash ];
    environment = {
      NETLIFY_DDNS_RC_FILE = "/root/deno-netlify-ddns-client/.env";
    };
    script = ''
      bash /root/deno-netlify-ddns-client/netlify-ddns-client.sh
    '';
  };
  systemd.timers.deno-netlify-ddns-client = {
    wantedBy = [ "timers.target" ];
    partOf = [ "deno-netlify-ddns-client.service" ];
    timerConfig = {
      OnBootSec = "10sec";
      OnUnitActiveSec = "5min";
      Unit = "deno-netlify-ddns-client.service";
    };
  };

  services.smartd.enable = true;
  services.caddy = {
    enable = true;
    adapter = "caddyfile";
    # acmeCA = "https://acme-staging-v02.api.letsencrypt.org/directory";
    configFile = pkgs.writeText "Caddyfile" ''
      video.lyte.dev {
        reverse_proxy :8096
      }

      bw.lyte.dev {
        reverse_proxy :8222
      }

      api.lyte.dev {
        reverse_proxy :5757
      }

      a.lyte.dev {
        reverse_proxy :8899
      }

      git.lyte.dev {
        reverse_proxy :3088
      }

      files.lyte.dev {
        file_server browse {
          root /storage/files.lyte.dev
        }
      }
        
      # proxy everything else to chromebox
      :80 {
        reverse_proxy 10.0.0.5:80
      }

      :443 {
        reverse_proxy 10.0.0.5:443
      }
    '';
  };

  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://bw.lyte.dev";
      SIGNUPS_ALLOWED = "false";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
    };
  };

  services.gitea = {
    enable = true;
    appName = "git.lyte.dev";
    stateDir = "/storage/gitea";
    settings = {
      server = {
        ROOT_URL = "https://git.lyte.dev";
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3088;
        DOMAIN = "git.lyte.dev";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      session = {
        COOKIE_SECURE = true;
      };
      log = {
        # TODO: raise the log level
        LEVEL = "Debug";
      };
      ui = {
        THEMES = "catppuccin-mocha-sapphire,gitea,arc-green,auto,pitchblack";
        DEFAULT_THEME = "catppuccin-mocha-sapphire";
      };
    };
    lfs = {
      enable = true;
    };
    dump = {
      enable = true;
    };
    database = {
      # TODO: move to postgres?
      type = "sqlite3";
    };
  };

  # TODO: ensure we're not doing the same dumb thing we were doing on the old host and eating storage
  services.clickhouse.enable = true;

  services.plausible = {
    enable = true;
    releaseCookiePath = config.sops.secrets.plausible-erlang-cookie.path;
    database = {
      clickhouse.setup = true;
      postgres = {
        setup = false;
        dbname = "plausible";
      };
    };
    server = {
      baseUrl = "http://beefcake.hare-cod.ts.net:8899";
      disableRegistration = true;
      port = 8899;
      secretKeybaseFile = config.sops.secrets.plausible-secret-key-base.path;
    };
    adminUser = {
      activate = false;
      email = "daniel@lyte.dev";
      passwordFile = config.sops.secrets.plausible-admin-password.path;
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "daniel" "plausible" ];
    ensureUsers = [
      {
        name = "daniel";
        ensurePermissions = {
          "DATABASE daniel" = "ALL PRIVILEGES";
        };
      }
      {
        name = "plausible";
        ensurePermissions = {
          "DATABASE plausible" = "ALL PRIVILEGES";
        };
      }
    ];
    dataDir = "/storage/postgres";
    enableTCPIP = true;

    package = pkgs.postgresql_15;

    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser    auth-method
      local all       postgres  peer map=superuser_map        
      local all       daniel    peer map=superuser_map        
      local sameuser  all       peer map=superuser_map        
      local plausible plausible peer map=superuser_map

      # lan ipv4
      host  all       all     10.0.0.0/24   trust

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

  services.postgresqlBackup = {
    enable = true;
    backupAll = true;
    compression = "none"; # hoping for deduplication here?
    location = "/storage/postgres-backups";
    startAt = "*-*-* 03:00:00";
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    # uses port 8096 by default, configurable from admin UI
  };

  # NOTE: this server's xeon chips DO NOT seem to support quicksync or graphics in general
  # but I can probably throw in a crappy GPU (or a big, cheap ebay GPU for ML
  # stuff, too?) and get good transcoding performance

  # jellyfin hardware encoding
  # hardware.opengl = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     intel-media-driver
  #     vaapiIntel
  #     vaapiVdpau
  #     libvdpau-va-gl
  #     intel-compute-runtime
  #   ];
  # };
  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  # };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
    listenAddresses = [
      { addr = "0.0.0.0"; port = 64022; }
      { addr = "0.0.0.0"; port = 22; }
    ];
  };

  services.samba-wsdd.enable = true;

  services.samba = {
    enable = true;
    openFirewall = true;
    securityType = "user";
    package = pkgs.sambaFull;

    extraConfig = ''
      workgroup = WORKGROUP
      server string = beefcake
      netbios name = beefcake
      security = user
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 10. 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
      load printers = yes
      printing = cups
      printcap name = cups
    '';
    shares = {
      libre = {
        path = "/storage/libre";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0666";
        "directory mask" = "0777";
        "force user" = "nobody";
        "force group" = "users";
      };
      public = {
        path = "/storage/public";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0664";
        "directory mask" = "0775";
        "force user" = "nobody";
        "force group" = "users";
      };
      family = {
        path = "/storage/family";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "0775";
        "force user" = "nobody";
        "force group" = "family";
      };
      daniel = {
        path = "/storage/daniel";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0640";
        "directory mask" = "0750";
        "force user" = "daniel";
        "force group" = "users";
      };
      printers = {
        comment = "All Printers";
        path = "/var/spool/samba";
        public = "yes";
        browseable = "yes";
        # to allow user 'guest account' to print.
        "guest ok" = "yes";
        writable = "no";
        printable = "yes";
        "create mode" = 0700;
      };
    };
  };

  # paths:
  # TODO: move previous backups over and put here
  # clickhouse and plausible analytics once they're up and running?

  services.restic.backups = rec {
    local = {
      initialize = true;
      passwordFile = "/root/restic-localbackup-password";
      paths = [
        "/storage/files.lyte.dev"
        "/storage/daniel"
        "/storage/gitea" # TODO: should maybe use configuration.nix's services.gitea.dump ?
        "/var/lib/bitwarden_rs" # does this need any sqlite preprocessing?
        # https://github.com/dani-garcia/vaultwarden/wiki/Backing-up-your-vault
        # specifically, https://github.com/dani-garcia/vaultwarden/wiki/Backing-up-your-vault#sqlite-database-files

        "/storage/postgres-backups"
      ];
      exclude = [ ];
      repository = "/storage/backups/local";
    };
    rascal = {
      initialize = true;
      extraOptions = [
        "sftp.command='ssh beefcake@rascal -i /root/.ssh/id_ed25519 -s sftp'"
      ];
      passwordFile = local.passwordFile;
      paths = local.paths;
      repository = "sftp://beefcake@rascal://storage/backups/beefcake";
      timerConfig = {
        OnCalendar = "04:45";
      };
    };
    # TODO: add ruby?
    benland = {
      initialize = true;
      extraOptions = [
        "sftp.command='ssh daniel@n.benhaney.com -p 10022 -i /root/.ssh/id_ed25519 -s sftp'"
      ];
      passwordFile = local.passwordFile;
      paths = local.paths;
      repository = "sftp://daniel@n.benhaney.com://storage/backups/beefcake";
      timerConfig = {
        OnCalendar = "04:45";
      };
    };
  };

  # TODO: https://nixos.wiki/wiki/Binary_Cache

  networking.firewall.allowedTCPPorts = [
    80 # http (caddy)
    443 # https (caddy)
    # 5357 # ???
    22 # ssh
    64022 # ssh (for ben?)
  ];
  networking.firewall.allowedUDPPorts = [
    # 53 # DNS
    # 3702 # ???
    64020 # mosh (for ben?)
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      # mosh
      from = 60000;
      to = 60010;
    }
  ];

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  # TODO: should I upgrade this?

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
