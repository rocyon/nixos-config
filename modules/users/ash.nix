{
  __findFile,
  den,
  ...
}: {
  flake-file.inputs = {
    # used for neovim
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.ash = {lib, ...}:
    den.lib.parametric
    <| {
      includes = lib.flatten [
        (builtins.attrValues den.aspects.ash._)

        [
          <app/comma>
          <app/helium>
        ]

        ({host, ...}: {
          includes =
            lib.optionals host.isGraphical
            (lib.attrValues den.aspects.ash._.graphical._);
        })
      ];

      nixos = {config, ...}: {
        assertions = [
          {
            assertion = config.programs.niri.enable;
            message = "user ash requires programs.niri";
          }
        ];
      };
    };
}
