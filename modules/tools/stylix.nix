{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.tools._.stylix = {base16Scheme}: {
    homeManager = {lib, ...}: {
      imports = [inputs.stylix.homeModules.stylix];
      stylix.enable = lib.mkDefault true;
    };

    includes = [
      (den.lib.take.exactly ({
        base16Scheme,
        global,
      }:
        if !global
        then {}
        else {
          nixos = {
            lib,
            pkgs,
            ...
          }: {
            imports = [inputs.stylix.nixosModules.stylix];
            stylix.base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/${base16Scheme}.yaml";
          };
        }))

      (den.lib.take.exactly ({base16Scheme}: {
        homeManager = {
          lib,
          pkgs,
          ...
        }: {
          stylix = lib.mkDefault {
            base16Scheme = "${pkgs.base16-schemes}/share/themes/${base16Scheme}.yaml";
          };
        };
      }))

      ({user,...}: {
        homeManager = {
          lib,
          pkgs,
          ...
        }: {
          # set priority just below mkDefault, so that mkDefault still takes priority over this
          stylix.base16Scheme =
            lib.optional (user ? colorscheme)
            <| lib.mkOverride 1001 "${pkgs.base16-schemes}/share/themes/${user.colorscheme}.yaml";
        };
      })
    ]; #includes
  };
}
