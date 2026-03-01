{
  den.aspects.hardware._.bluetooth = {
    nixos = {pkgs, ...}: {
      services.blueman.enable = true;

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      environment.systemPackages = with pkgs; [bluetui];
    };
  };
}
