# The overarching config settings for all hosts
# Contains 'host-spec' settings that have symptoms
{inputs,lib, ...}: {
  den.base.host = {
    isGraphical = lib.mkDefault false;

    home-manager.enable = true;
  };

  den.hosts = {
    x86_64-linux.xenia = {
      isGraphical = true;

    };

    aarch64-linux.azelf = {
      wsl.enable = true;

        users.ash = {};
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
          assertion = config ? home-manager -> config.home-manager.users ? ash;
          message = "user ash not found";
        }
      ];
    };
  };
}
