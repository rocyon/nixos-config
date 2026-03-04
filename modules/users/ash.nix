{
  __findFile,
  den,
  inputs,
  lib,
  ...
}: {
  flake-file.inputs = {
    # used for neovim
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.ash = {host, ...}: let
    inherit (inputs) secrets;
  in
    den.lib.parametric
    <| {
      includes = lib.flatten [
        <app/helium>
        <tools/comma>
        <tools/yazi>

        (<app/jujutsu> secrets.users.ash.jujutsu)

        # automatically include all aspects in ash._.*
        (builtins.attrValues den.aspects.ash._)

        # Change if ash._.graphical._.* is imported based on host-specification
        ({
          host,
          user,
        }: let
          isGraphical = host.isGraphical or false;
        in {
          includes = lib.optionals host.isGraphical (lib.attrValues den.aspects.ash._.graphical._);

          nixos = {config, ...}: {
            assertions = [
              {
                assertion = isGraphical -> config.programs.niri.enable;
                message = "user ash requires programs.niri";
              }
            ];
          };
        })
      ];

      homeManager = {pkgs, ...}: {
        # imports = [inputs.stylix.homeModules.stylix];
        # stylix = {
        #   enable = true;
        #   opacity.terminal = 0.75;
        #   base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        # };
      };

      nixos = {pkgs, ...}: {
        programs.dconf.enable = true; # Required because of config.xdg?
      };
    };
}
