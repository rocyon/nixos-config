{
  den.aspects.hardware._.audio = {
    nixos.services.pipewire = {
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };
}
