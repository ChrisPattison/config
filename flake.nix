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

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      tempeh = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./tempeh-nixos/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.chris = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };

    homeConfigurations.chris = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      configuration = import ./home.nix;
      username = "chris";
      homeDirectory = "/home/chris";
      stateVersion = "22.05";
    };
  };
}
