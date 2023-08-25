# Welcome to my nix config! I'm just getting started with flakes, so please
# forgive the mess.

# TODO: declarative disks with https://github.com/nix-community/disko
# TODO: home-manager?

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    # TODO: this could be a release tarball? fully recompiling this on every change suuuucks
    api-lyte-dev.url = "git+ssh://gitea@git.lyte.dev/lytedev/api.lyte.dev.git";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";

      # use the version of nixpkgs we specified above rather than the one HM would ordinarily use
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/master"; # NOTE: lock update!

      # use the version of nixpkgs we specified above rather than the one HM would ordinarily use
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations = {
      beefcake = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = let
          ald = inputs.api-lyte-dev;
          nomod = builtins.trace "hey" ald.nixosModules;
        in [
          ./machines/beefcake.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
          nomod.x86_64-linux.api-lyte-dev
          {
            home-manager.useGlobalPkgs = true;
          }
        ];
      };

      thinker = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.disko.nixosModules.disko
          ./machines/thinker-disks.nix
          { _module.args.disks = [ "/dev/nvme0n1" ]; }
          ./machines/thinker.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.daniel = import ./daniel.nix;
          }
        ];
      };
    };
  };
}
