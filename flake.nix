{
  description = "NixOS configuration";

  inputs = {
    # Nixpkgs release
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Nixpkgs unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Emacs overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, emacs-overlay, ... }:
    let
      pkgs = (system: import nixpkgs { inherit system; overlays = [ emacs-overlay.overlays.default ]; });
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
          pkgs = (pkgs "x86_64-linux");
          extraSpecialArgs = {
            inherit nixpkgs-unstable;
          };
          modules = [
            ./homes/home.nix
          ];
        };
        
        nadine = home-manager.lib.homeManagerConfiguration {
          pkgs = (pkgs "x86_64-linux");
          modules = [
            ./homes/nadine-home.nix
          ];
        };
        
        mba = home-manager.lib.homeManagerConfiguration {
          pkgs = (pkgs "aarch64-darwin");
          modules = [
            ./homes/darwin-home.nix
          ];
        };
      };
    };
}
