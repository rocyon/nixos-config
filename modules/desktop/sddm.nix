{
  den.aspects.desktop._.sddm = {
    nixos.services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
