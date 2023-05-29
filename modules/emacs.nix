{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.my.emacs;
in {
  imports = [
  ];

  options = {
    my.emacs = {
      enable = mkEnableOption "Customized emacs";
      package = mkOption {
        type = types.package;
        default = pkgs.emacs;
        defaultText = literalExpression "pkgs.emacs";
        example = literalExpression "pkgs.emacs25-nox";
        description = "The Emacs package to use.";
      };
    };
  };

  config = mkIf cfg.enable {
      programs.emacs = let
        emacs = pkgs.emacsWithPackagesFromUsePackage {
          config = ../rc/emacs.d/init.el;
          defaultInitFile = true;
          package = cfg.package;
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
