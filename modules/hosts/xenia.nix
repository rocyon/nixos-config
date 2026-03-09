{__findFile, ...}: {
  den.aspects.xenia.includes = [
    (<facter> {report = "framework16";})

    <hardware/audio>
    <hardware/systemd-boot>
    <hardware/bluetooth>
    <hardware/framework16>

    #<desktop/niri>
    <desktop/sddm>
    <desktop/aero7>

    <app/steam>
    <tools/twingate>
    <tools/tailscale>
    <tools/sunshine>
  ];

  den.aspects.xenia.nixos = {
    config,
    pkgs,
    lib,
    ...
  }: let
    mkBtrfs = import ./_mkBtrfs.nix {inherit lib;};
  in {
    fileSystems =
      {
        "/boot" = {
          device = "/dev/disk/by-uuid/0ED5-65AF";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      }
      // (mkBtrfs {
          device = "/dev/disk/by-uuid/5bf2e86e-cab5-4af1-8d3d-b3b4b1d12af0";
          defaultOptions = ["compress" "noatime"];
          optionsBySubvol."@home" = ["compress"];
        } {
          "/" = "@";
          "/home" = "@home";
          "/nix" = "@nix";
        });

    system.stateVersion = "25.05";

    services.ddccontrol.enable = true;
    environment.systemPackages = [pkgs.ddccontrol-db];

    boot.extraModulePackages = with config.boot.kernelPackages; [ddcci-driver];

    assertions = [
      {
        assertion = !(config ? disko);
        message = "Xenia disallows disko";
      }
    ];
  };
}
