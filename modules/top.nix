{ config, pkgs, lib, ...}:
with lib;
imports = [
  ./git.nix
  ./email.nix
];
