{ config, pkgs, lib, zed-editor, nixpkgs-unstable, ...}:
with lib;
let
  cfg = config.my.zed-editor;
  pkgs-unstable-zed = import nixpkgs-unstable { system = pkgs.system; overlays = [
    zed-editor.overlays.zed-editor
    zed-editor.overlays.rust-toolchain
    zed-editor.overlays.fenix
  ]; };
in {
  imports = [
  ];

  options = {
    my.zed-editor = {
      enable = mkEnableOption "Customized zed editor";
    };
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      package = pkgs-unstable-zed.zed-editor;
      extensions = [
        "typst"
        "nix"
        "latex"
      ];
    };
  };
}
