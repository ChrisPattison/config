{ pkgs, lib, ...}:
{
  imports = [
    ../modules/top.nix
  ];

  home.stateVersion = "22.11";

  home.username = "chris";
  home.homeDirectory = "/Users/chris";
  
  home.packages = [ pkgs.home-manager pkgs.htop pkgs.texlive.combined.scheme-full pkgs.ghostscript pkgs.lean4 pkgs.typst pkgs.typst-lsp pkgs.cargo pkgs.rustc pkgs.inkscape];

  nix.package = pkgs.nix;
  nix.settings = {
    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  my.emacs = {
    enable = true;
    package = pkgs.emacsMacport;
  };

  my.git.enable = true;
}
