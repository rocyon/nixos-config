{den,...}: {
  den.aspects.hardware._.systemd-boot = {
    nixos = {lib,...}: {
      boot.loader = {
        systemd-boot.enable = true;
        timeout = lib.mkDefault 15;
        efi.canTouchEfiVariables = true;
      };
    };

    includes = map den.lib.take.exactly [
      ({timeout}: {
        nixos.boot.loader.timeout = timeout;
      })
    ];
  };
}
