{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.my.git;
in {
  imports = [
    ./git.nix
    ./emacs.nix
    ./email.nix
    ./zed-editor.nix
  ];
}
