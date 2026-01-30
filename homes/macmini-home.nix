
{ pkgs, lib, ...}:
{
  imports = [
    ../modules/top.nix
  ];

  home.stateVersion = "25.11";

  home.username = "chris";
  home.homeDirectory = "/Users/chris";

  nixpkgs.config.allowUnfreePredicate = (pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
  ]);

  
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
    pkgs.zotero
    # pkgs.zulip
    pkgs.skimpdf
    pkgs.nixd
  ];

  nix.package = pkgs.nix;
  nix.settings = {
    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.obsidian = {
    enable = true;
  };
  
  fonts.fontconfig.enable = true;

  my.git.enable = true;
}
