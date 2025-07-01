{
  description = "System Config Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils, home-manager, ... }:
    let
      # Define per-host module lists here
      hostModules = {
        kass-fw16 = [
          ./modules/gaming.nix
          ./modules/mount.nix
        ];
        kass-dev-nix = [
          ./modules/mount.nix
        ];
        # Add more hosts and their modules as needed
        # other-host = [ ./modules/other.nix ];
      };

      mkHost = name: system: {
        ${name} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            [
              ./hosts/${name}/configuration.nix
              ./hosts/${name}/hardware-configuration.nix
              ./modules/common.nix
            ]
            ++ (hostModules.${name} or [])
            ++ [
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = ".bak";
                home-manager.users.krode = import ./home/${name}.nix;
              }
            ];
        };
      };
    in {
      nixosConfigurations = mkHost "kass-fw16" "x86_64-linux" // mkHost "kass-dev-nix" "x86_64-linux";
      # Add more hosts here as needed
      # // mkHost "other-host" "x86_64-linux"
    };
}

