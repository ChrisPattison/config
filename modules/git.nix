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
    programs.git.settings = {
      enable = true;
      user.name = "Chris Pattison";
      user.email = "chpattison@gmail.com";
      pull.rebase = false;
      rebase.autoSquash = true;
      core.editor = "nano";
      init.defaultBranch = "main";
    };
  };
}
