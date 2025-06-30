{
  description = "System Config Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.kass-fw16 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
