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

  den.aspects.ash = {...}:let
    inherit (inputs) secrets;
    inherit (builtins) attrValues;
  in
    den.lib.parametric {
      includes =
        lib.flatten [
          <schema>
          <app/helium>
          <tools/comma>
          <tools/yazi>

          (<app/jujutsu> secrets.users.ash.jujutsu)

          # automatically include all provides
          (attrValues den.aspects.ash._)
        ]
        ++ [
          ({host, ...}: {
            nixos = {
              config,
              ...
            }: {
              programs.dconf.enable = true; # Required because of config.xdg?
              assertions = [
                {
                  assertion = host.isGraphical -> config.programs.niri.enable;
                  message = "user ash requires programs.niri";
                }
              ];
            };
          })
        ];

      homeManager = {
        home.shell.enableBashIntegration = true;
        programs.bash.enable = true;
      };
    };
}
