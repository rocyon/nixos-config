{
  den.aspects.hardware._.bluetooth.nixos = {
    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      #hsphfpd.enable = true;
    };
  };
}
