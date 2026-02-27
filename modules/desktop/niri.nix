{...}: {
  den.aspects.desktop._.niri = {
    nixos = {pkgs, ...}: {
      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };

      services.gnome.gnome-keyring.enable = true;
    };
  };
}
