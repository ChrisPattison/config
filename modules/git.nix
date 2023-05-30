{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.my.git;
in {
  imports = [
  ];

  options = {
    my.git = {
      enable = mkEnableOption "Customized git";
    };
  };

  config = mkIf cfg.enable {
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
  };
}
