# The overarching config settings for all hosts
# Contains 'host-spec' settings that have symptoms
{
  inputs,
  ...
}: {
  den.schema.host = {lib,...}: {
    options.isGraphical = lib.mkEnableOption "State whether the host has graphical responsibilities";
  };

  den.hosts = {
    x86_64-linux.xenia = {
      isGraphical = true;
      users.ash.classes = ["homeManager"];
    };

    aarch64-linux.azelf = {
      wsl.enable = true;
      users.ash = {};
      users.ash.classes = ["homeManager"];
    };
  };

  den.ctx.hm-host = {
    nixos.home-manager = {
      useGlobalPkgs = true;
      backupFileExtension = "hm-bk";
    };
  };

  den.ctx.host = {
    nixos = {config, ...}: {
      imports = [inputs.home-manager.nixosModules.default];
      assertions = [
        {
          assertion = config ? home-manager;
          message = "home-manager required";
        }
        {
          assertion = config.users.users ? ash;
          message = "user ash not found";
        }
        {
          assertion = config ? home-manager -> config.home-manager.users ? ash;
          message = "user ash not found in home-manager";
        }
      ];
    };
  };
}
