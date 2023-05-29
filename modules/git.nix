{ pkgs, lib, ...}:
{
  imports = [
  ];

  options = {
  };

  config = {
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
