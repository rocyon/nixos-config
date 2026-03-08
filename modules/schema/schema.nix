{
  den,
  lib,
  ...
}: let
  inherit (lib) types mkOption;
in {
  den.aspects.schema = den.lib.parametric {
    includes = builtins.attrValues den.aspects.schema._;
  };

  den.schema.host.options = {
    isGraphical = lib.mkOption {
      type = types.bool;
      default = false;

      description = ''
        Whether the host has graphical responsibilities
        Eg. SSH/TTY Only client   : False
            Graphical Environment : True
      '';
    };

    isSlim = lib.mkOption {
      type = types.bool;
      default = false;

      description = ''
        Whether the host has limited hardware, and actions taken accordingly
        Eg. Limited RAM, Disk, ect.
      '';
    };

    wallpaper = mkOption {
      type = with types; nullOr path;
      default = null;
      description = ''
        The wallpaper to be used where applicable
        Eg. Login screen
      '';
    };
  };

  den.schema.user.options = {
    wallpaper = mkOption {
      type = with types; nullOr path;
      default = null;

      description = ''
        The wallpaper used on the user's desktop
        Not absolute, could be overridden at runtime by another application
      '';
    };
  };

  den.schema.home.options = {};
}
