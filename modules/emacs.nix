{ pkgs, lib, ...}:
{
  imports = [
  ];

  options = {
  };

  config = {
      programs.emacs = let
        emacs = pkgs.emacsWithPackagesFromUsePackage {
          config = ../rc/emacs.d/init.el;
          defaultInitFile = true;
        };
      in {
        enable = true;
        package = emacs;
      };

      home.file.".emacs.d/snippets" = {
        source = ../rc/emacs.d/snippets;
        recursive = true;
      };
  };
}
