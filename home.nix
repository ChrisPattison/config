{ pkgs, ...}:
{

  imports = [
    #nur-no-pkgs.repos.rycee.hmMOdules.emacs-init
  ];

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.htop
    pkgs.git
    pkgs.firefox
    pkgs.libfido2
  ];

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
  };

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
