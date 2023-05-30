{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.my.email;
in {
  imports = [
  ];

  options = {
    my.email = {
      enable = mkEnableOption "Customized email";
    };
  };

  config = mkIf cfg.enable {
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
  };
}
