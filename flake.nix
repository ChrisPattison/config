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
      pkgs = (system: import nixpkgs { inherit system; overlays = [ emacs-overlay.overlays.default ]; });
      linux-pkgs = pkgs "x86_64-linux";
      darwin-pkgs = pkgs "x86_64-darwin";
    in {
      nixosConfigurations = {
        tempeh = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/tempeh/configuration.nix
          ];
        };
      };
      
      homeConfigurations = {
        chris = home-manager.lib.homeManagerConfiguration {
          pkgs = linux-pkgs;
          modules = [
            ./homes/home.nix
          ];
        };
        
        nadine = home-manager.lib.homeManagerConfiguration {
          pkgs = linux-pkgs;
          modules = [
            ./homes/nadine-home.nix
          ];
        };

        darwin = home-manager.lib.homeManagerConfiguration {
          pkgs = darwin-pkgs;
          modules = [
            ./homes/darwin-home.nix
          ];
        };
      };
    };
}
