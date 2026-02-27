{
  __findFile,
  inputs,
  ...
}: {
  flake-file.inputs = {
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.ash._.niri = {
    includes = (builtins.foldl' (acc: e: acc ++ e) []) [
      [<desktop/niri>]
    ];

    homeManager = {
      services.mako = {
        enable = true;
        settings = {
          actions = true;
          anchor = "top-right";
          border-radius = 0;
          default-timeout = 0;
          height = 100;
          width = 300;
          icons = true;
          ignore-timeout = false;
          layer = "top";
          margin = 10;
          markup = true;

          # Section example
          "actionable=true" = {
            anchor = "top-left";
          };
        };
      };

      programs.fuzzel.enable = true;
    };
  };
}
