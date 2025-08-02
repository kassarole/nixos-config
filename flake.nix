{
  description = "Kassiopia's Nix Configs";
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
        metis = [
          ./modules/gaming.nix
          ./modules/mount.nix
          ./modules/gui.nix
          ./modules/hyprland.nix
        ];
        selene = [
          ./modules/mount.nix
          ./modules/dev.nix
          ./modules/virtualmachine.nix
        ];
        nike = [
        ];
        hestia = [
          ./modules/gaming.nix
          ./modules/mount.nix
          ./modules/gui.nix
          ./modules/ctftools.nix
          ./modules/hyprland.nix
        ];
        hephaestus = [
          ./modules/mount.nix
          ./modules/virtualmachine.nix
        ];
        eros = [
          ./modules/virtualmachine.nix
        ];
        gaia = [
          ./modules/virtualmachine.nix
          ./modules/dev.nix
        ];
        hermes = [
          ./modules/sdr.nix
          ./modules/dev.nix
        ];
        circe = [
          ./modules/mount.nix
          ./modules/virtualmachine.nix
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
      nixosConfigurations = mkHost "metis" "x86_64-linux" // mkHost "selene" "x86_64-linux" // mkHost "hestia" "x86_64-linux" // mkHost "hephaestus" "x86_64-linux" // mkHost "eros" "x86_64-linux" // mkHost "gaia" "x86_64-linux" // mkHost "hermes" "x86_64-linux" // mkHost "circe" "x86_64-linux";
        # Add more hosts here as needed
        # other-host = mkDarwinHost "other-host" "x86_64-darwin";
      darwinConfigurations = mkDarwinHost "nike" "aarch64-darwin";
      # Add more hosts here as needed
      # // mkHost "other-host" "x86_64-linux"
    };
}

