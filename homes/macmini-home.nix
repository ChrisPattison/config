
{ pkgs, lib, ...}:
{
  imports = [
    ../modules/top.nix
  ];

  home.stateVersion = "25.11";

  home.username = "chris";
  home.homeDirectory = "/Users/chris";

  home.packages = [
    pkgs.home-manager
    pkgs.htop
    pkgs.texlive.combined.scheme-full
    pkgs.typst
    pkgs.tinymist
    pkgs.cargo
    pkgs.rustc
    pkgs.inkscape
    pkgs.lmodern
    pkgs.lmmath
    pkgs.texlab
    pkgs.skimpdf
  ];

  nix.package = pkgs.nix;
  nix.settings = {
    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  fonts.fontconfig.enable = true;

  my.git.enable = true;
  
  my.obsidian.enable = true;
}
