{lib,...}: {
  den.aspects.desktop._.sddm = {
    nixos.services.displayManager.sddm = {
      enable = lib.mkDefault true;
      wayland.enable = lib.mkDefault true;
    };
  };
}
