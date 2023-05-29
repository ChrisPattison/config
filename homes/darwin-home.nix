{ pkgs, lib, ...}:
{
  imports = [
    ../modules/emacs.nix
    ../modules/git.nix
  ];

  home.stateVersion = "22.11";

  home.username = "chris";
  home.homeDirectory = "/Users/chris";
  
  home.packages = [ pkgs.home-manager ];

  my.emacs = {
    enable = true;
    package = pkgs.emacsMacport;
  };
}
