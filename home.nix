{ pkgs, lib, ...}:
{

  imports = [
    ./modules/emacs.nix
  ];

  nixpkgs.config.allowUnfreePredicate = (pkg: builtins.elem (lib.getName pkg) [
    "slack"
    "zoom"
    "discord"
  ]);

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.stateVersion = "22.11";

  home.packages = let
    python-with-pkgs = (pkgs.python3.withPackages (python-packages: with python-packages; [
        pandas
        numpy
        scipy
        matplotlib
        pytest
        networkx
    ]));
    latex = pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-full latex-bin latexmk adjustbox beamer
            beamertheme-metropolis pgfopts fontspec thmtools braket quantikz
            xargs xstring environ tikz-cd tabto-ltx tikzmark collection-latex
            biblatex tikz-3dplot psnfss babel siunitx physics pgfplots mathtools
            tikzsymbols xkeyval collectbox collection-mathscience float qrcode;
    };
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
    pkgs.discord
    latex
  ];

  xdg = {
    enable = true;
    mimeApps = {
      # enable = true;
    };
  };
  
  dconf.settings = {
    "/org/gnome/desktop/interface" = {
      # scaling-factor = 2;
    };
  };
  
  programs.firefox = {
    enable = true;
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
    shellAliases = {
      "open" = "xdg-open";
    };
  };

  programs.git = {
    enable = true;
    userName = "Chris Pattison";
    userEmail = "chpattison@gmail.com";
    extraConfig = {
      pull.rebase = false;
      rebase.autoSquash = true;
      core.editor = "nano";
      init.defaultBranch = "main";
    };
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
