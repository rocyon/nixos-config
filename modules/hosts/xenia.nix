{__findFile, ...}: {
  den.aspects.xenia.includes = [
    (<facter> {report = "framework-16";})
    <sops>

    <hardware/audio>
    <hardware/systemd-boot>
    <hardware/bluetooth>
    <hardware/framework16>

    #<desktop/niri>
    <desktop/sddm>

    <app/steam>
    <app/comma>
  ];

  den.aspects.xenia.nixos = {
    config,
    lib,
    ...
  }: let
    mkBtrfs = {
      device,
      defaultOptions ? [],
      optionsBySubvol ? [],
    }:
      lib.mapAttrs (_: subvol: {
        inherit device;
        fsType = "btrfs";
        options = lib.concatLists [
          (optionsBySubvol.${subvol} or defaultOptions)
          (lib.optionals (null != subvol) ["subvol=${subvol}"])
        ];
      });
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

    programs.dconf.enable = true;
    system.stateVersion = "25.05";

    assertions = [
      {
        assertion = !(config ? disko);
        message = "Xenia disallows disko";
      }
    ];
  };
}
