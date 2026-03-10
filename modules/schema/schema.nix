{
  den,
  lib,
  parametric,
  ...
}: let
  inherit (lib) types mkOption;
in {
  den.aspects.schema = parametric {
    includes = lib.attrValues den.aspects.schema._;
  };

  den.ctx.user._.inheritHost = {host, ...}:
    lib.mkDefault {
      inherit (host)
        isGraphical
        isSlim
        wallpaper
        ;
    };

  den.schema.conf.options = {
    isGraphical = lib.mkOption {
      type = types.bool;
      default = false;

      description = ''
        Whether the host has graphical responsibilities
      '';
    };

    isSlim = lib.mkOption {
      type = types.bool;
      default = false;

      description = ''
        Whether the host has limited hardware resources, and actions taken accordingly
      '';
    };

    wallpaper = mkOption {
      type = with types; nullOr path;
      default = null;
      description = ''
        The wallpaper to be used
      '';
    };
  };
}
