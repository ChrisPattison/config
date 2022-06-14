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
  in [
    pkgs.htop
    python-with-pkgs
    pkgs.cmake
    pkgs.gcc
    pkgs.git
    pkgs.nodejs
  ];

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
  };
}
