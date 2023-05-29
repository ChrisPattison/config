{
  description = "NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Emacs overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, emacs-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; overlays = [ emacs-overlay.overlays.default ]; };
    in {
      nixosConfigurations = {
        tempeh = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./tempeh-nixos/configuration.nix
          ];
        };
      };
      
      homeConfigurations.chris = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };

      homeConfigurations.darwin = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./darwin-home.nix
        ];
      };
    };
}
