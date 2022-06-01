{ pkgs, ...}:
{

  nixpkgs.config.allowUnfree = true;

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.slack
  ];

}
