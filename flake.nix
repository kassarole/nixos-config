{
  description = "System Config Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils, home-manager, nix-darwin, plasma-manager, ... }:
    let
      # Define per-host module lists here
      hostModules = {
        kass-fw16 = [
          ./modules/gaming.nix
          ./modules/mount.nix
          ./modules/gui.nix
        ];
        kass-dev-nix = [
          ./modules/mount.nix
          ./modules/dev.nix
        ];
        kass-mbp = [
        ];
        kass-desktop = [
          ./modules/gaming.nix
          ./modules/mount.nix
          ./modules/gui.nix
        ];
        # Add more hosts and their modules as needed
        # other-host = [ ./modules/other.nix ];
      };

      mkHost = name: system: {
        ${name} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            [
              ./hosts/${name}/nixos/configuration.nix
              ./hosts/${name}/nixos/hardware-configuration.nix
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
                home-manager.extraSpecialArgs = {
                  inherit plasma-manager;
                };
              }
            ];
        };
      };
      mkDarwinHost = name: system: {
        ${name} = nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./hosts/${name}/darwinconfiguration.nix
            ./modules/darwin-common.nix
            ./modules/darwin-gui.nix
          ]
          ++ (hostModules.${name} or [])
          ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "back";
              home-manager.users.krode = import ./home/${name}.nix;
            }
          ];
        };
      };
    in {
      nixosConfigurations = mkHost "kass-fw16" "x86_64-linux" // mkHost "kass-dev-nix" "x86_64-linux" // mkHost "kass-desktop" "x86_64-linux";
      darwinConfigurations = mkDarwinHost "kass-mbp" "aarch64-darwin";
      # Add more hosts here as needed
      # // mkHost "other-host" "x86_64-linux"
    };
}

