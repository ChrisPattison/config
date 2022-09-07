{ pkgs, lib, ...}:
{
  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  nix.package = pkgs.nix;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

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
    pkgs.tmux
    pkgs.libfido2
    python-with-pkgs
  ];

  programs.git = {
    enable = true;
    userName = "Chris Pattison";
    userEmail = "chpattison@gmail.com";
  };
  
  programs.emacs = {
    enable = true;
    extraConfig = builtins.readFile (./. + "/rc/init.el");
  };
}
