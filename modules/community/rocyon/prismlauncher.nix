{lib, ...}: let
  inherit (builtins) mapAttrs;
  inherit (lib) types;
in {
  # rocyon.prismlauncher = {
  #   homeManager = {
  #     config,
  #     pkgs,
  #     ...
  #   }: {
  #     options.programs.prismlauncher = {
  #       config = lib.mkOption {
  #         type = with types; str;
  #         default =
  #           pkgs.writers.writeTOML
  #           config.programs.prismlauncher.settings;
  #       };
  #
  #       settings = {
  #         General = {
  #           ApplicationTheme = {
  #             types = with types; str;
  #           };
  #         };
  #
  #         UI = {
  #         };
  #       };
  #     };
  #   };
  # };
}
