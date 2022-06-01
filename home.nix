{ pkgs, lib, ...}:
{

  imports = [
    #nur-no-pkgs.repos.rycee.hmMOdules.emacs-init
  ];

  nixpkgs.config.allowUnfreePredicate = (pkg: builtins.elem (lib.getName pkg) [
    "slack"
    "mathematica"
  ]);

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.packages = let
    texlive = (pkgs.texlive.combine { inherit (pkgs.texlive) 
            scheme-medium collection-fontsextra adjustbox cleveref 
            makecell enumitem collectbox thmtools braket relsize preprint
            standalone quantikz xargs xstring environ tikz-cd pythontex revtex; });
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
    pkgs.libfido2
    texlive
    python-with-pkgs
    pkgs.slack
    pkgs.mathematica
  ];

  programs.firefox = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
  };

  programs.git = {
    enable = true;
    userName = "Chris Pattison";
    userEmail = "chpattison@gmail.com";
  };

  programs.zathura = {
    enable = true;
    extraConfig = builtins.readFile (./. + "/rc/emacs-key-for-zathura.txt");
  };

  programs.emacs = {
    enable = true;
    extraConfig = builtins.readFile (./. + "/rc/init.el");
  };
}
