{inputs, ...}: {
  flake-file.inputs = {
    aerothemeplasma-nix = {
      url = "github:nyakase/aerothemeplasma-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.desktop._.aero7 = {
    nixos = {
      imports = [inputs.aerothemeplasma-nix.nixosModules.aerothemeplasma-nix];

      boot.plymouth.enable = true;
      services.displayManager.sddm.enable = true;
      services.desktopManager.plasma6.enable = true;
      services.displayManager.defaultSession = "aerothemeplasma"; # if you want

      programs.aeroshell = {
        enable = true;
        #fonts.enable = true;
        polkit.enable = true;
        aerothemeplasma = {
          enable = true;
          sddm.enable = true;
          #plymouth.enable = true;
        };
      };
    };
  };
}
