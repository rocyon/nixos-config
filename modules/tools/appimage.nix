{den, ...}: {
  den.aspects.tools._.appimage = den.lib.parametric {
    nixos = {
      config,
      lib,
      pkgs,
      ...
    }: {
      options.appimage.extraPkgs = lib.mkOption {
        type = with lib.type; listOf str;
        default = [];
      };

      config.programs.appimage = {
        enable = true;
        binfmt = true;
        package = pkgs.appimage-run.override {
          extraPkgs = pkgs: lib.genAttrs config.appimage.extraPkgs (n: pkgs.${n});
        };
      };
    };

    includes = [
      ({extraPkgs}: {
        nixos.appimage.extraPkgs = [extraPkgs];
      })
    ];
  };
}
