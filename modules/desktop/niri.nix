{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.desktop._.niri = {
    nixos = {pkgs, ...}: {
      imports = [inputs.niri.nixosModules.niri];
      environment.systemPackages = [pkgs.xwayland-satellite];

        nixpkgs.overlays = [inputs.niri.overlays.niri];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      niri-flake.cache.enable = true;
    };
  };
}
