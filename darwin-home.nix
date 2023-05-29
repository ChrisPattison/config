{ pkgs, lib, ...}:
{
  imports = [
    ./modules/emacs.nix
    ./modules/git.nix
  ];

  home.stateVersion = "22.11";
  home.packages = [ pkgs.homemanager ];
}
