{
  den,
  inputs,
  lib,
  ...
}: let
  inherit (den.lib) take;
  scheme = pkgs: scheme: "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
in {
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.schema.conf = {
    options.colorscheme = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      description = ''
        Colorscheme must exist within pkgs.base16-schemes
      '';
    };
  };

  den.aspects.schema._.colorscheme = den.lib.parametric {
    includes = map take.exactly [
      ({host}:
        lib.optionalAttrs (host.colorscheme != null) {
          nixos = {pkgs, ...}: {
            imports = [inputs.stylix.nixosModules.stylix];
            stylix = {
              enable = true;
              base16Scheme = scheme pkgs host.colorscheme;
            };
          };
        })

      ({
        host,
        user,
      }:
        take.unused host
        lib.optionalAttrs (user.colorscheme != null) {
          homeManager = {pkgs, ...}: {
            imports = [inputs.stylix.homeModules.stylix];
            stylix = {
              enable = true;
              base16Scheme = scheme pkgs user.colorscheme;
            };
          };
        })
    ];
  };
}
