{ pkgs, lib, ...}:
{
  imports = [
  ];

  options = {
  };

  config = {
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
