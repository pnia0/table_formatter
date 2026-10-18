{ config, lib, pkgs, ... }:
let
    cfg = config.programs.table-formatter;
in
{
  options.programs.table-formatter = {
    enable = lib.mkEnableOption "table-formatter";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./package.nix {};
      description = "table-formatter package to install";
    };
  };
  config = lib.mkIf cfg.enable {
    home.package = [ cfg.package ];
  };
}
