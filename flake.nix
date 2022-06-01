{
  description = "NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    homeConfigurations.chris = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      configuration = import ./home.nix;
      username = "chris";
      homeDirectory = "/home/chris";
      stateVersion = "22.05";
    };
  };
}
