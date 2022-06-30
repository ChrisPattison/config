{
  description = "NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NUR packages
    # nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        tempeh = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./tempeh-nixos/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.users.chris = import ./home.nix;
              home-manager.users.stan = import ./stan_home.nix;
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
      
      homeConfigurations.chris = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home.nix
        ];
      };
    };
}
