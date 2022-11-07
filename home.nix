{ pkgs, lib, ...}:
{

  imports = [
    #nur-no-pkgs.repos.rycee.hmMOdules.emacs-init
  ];

  nixpkgs.config.allowUnfreePredicate = (pkg: builtins.elem (lib.getName pkg) [
    "slack"
    "zoom"
  ]);

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

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
    pkgs.thunderbird
    pkgs.slack
    pkgs.zoom-us
    pkgs.zotero
    pkgs.rustc
    pkgs.cargo
    pkgs.cmake
    pkgs.gcc
  ];

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
    };
  };
  
  dconf.settings = {
    "/org/gnome/desktop/interface" = {
      # scaling-factor = 2;
    };
  };
  
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    ];
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
    ];
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
  };

  programs.git = {
    enable = true;
    userName = "Chris Pattison";
    userEmail = "chpattison@gmail.com";
    extraConfig = {
      pull.rebase = false;
      rebase.autoSquash = true;
      core.editor = "nano";
    };
  };

  programs.zathura = {
    enable = true;
    extraConfig = builtins.readFile (./. + "/rc/emacs-key-for-zathura.txt");
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraConfig = builtins.readFile (./. + "/rc/init.el");
  };

  accounts.email = {
    accounts.outlook = {
      primary = true;
      realName = "Chris Pattison";
      address = "cpattiso@caltech.edu";

      imap.host = "outlook.office365.com";
      smtp.host = "smtp.office365.com";
      userName = "cpattiso@caltech.edu";
    };
  };
}
