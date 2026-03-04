{
  den,
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.tools._.stylix = {
    base16Scheme,
    global ? false,
  }: {
    nixos = {pkgs, ...}:
      lib.optionalAttrs global {
        imports = [inputs.stylix.nixosModules.stylix];
        stylix.base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/${base16Scheme}.yaml";
      };

    homeManager = {pkgs, ...}: {
      imports = [inputs.stylix.homeModules.stylix];
      stylix = {
        enable = true;
        opacity.terminal = 0.75;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${base16Scheme}.yaml";
      };
    };
  };
}
