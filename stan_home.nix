{ pkgs, lib, ...}:
{
  home.username = "stan";
  home.homeDirectory = "/home/stan";

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home.packages = let
    python-with-pkgs = (pkgs.python3.withPackages (python-packages: with python-packages; [
        pandas
        numpy
        scipy
        matplotlib
        pytest
        networkx
    ]));
    vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = (with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }];
    }; 
  in [
    pkgs.htop
    python-with-pkgs
    pkgs.cmake
    pkgs.gcc
    pkgs.git
    pkgs.singularity
    vscode-with-extensions
  ];

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
  };
}
