{den, ...}: {
  den.aspects.hardware._.audio = {
    nixos.services.pipewire = {
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    includes = [
      (den.lib.take.exactly ({host}: {
        nixos = {
          pkgs,
          lib,
          ...
        }: {
          environment.systemPackages = with pkgs;
            lib.optionals host.isGraphical [pavucontrol];
        };
      }))
    ];
  };
}
