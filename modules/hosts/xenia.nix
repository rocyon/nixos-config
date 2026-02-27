{__findFile, ...}: {
  den.hosts.x86_64-linux.xenia.users = {
    ash = {};
  };

  den.aspects.xenia = {
    nixos = {
      config,
      lib,
      modulesPath,
      pkgs,
      ...
    }: let
      mkBtrfs = {
        defaultOptions ? [],
        device,
        overrideDefaultOptionsBySubvol ? [],
        subvols,
      }:
        lib.mapAttrs' (mountPoint: subvol:
          lib.nameValuePair mountPoint {
            inherit device;
            fsType = "btrfs";
            options = (
              if (subvol == null)
              then defaultOptions
              else
                (overrideDefaultOptionsBySubvol.${subvol} or defaultOptions)
                ++ ["subvol=${subvol}"]
            );
          })
        subvols;
    in {
      fileSystems = let
        primaryDrive = mkBtrfs {
          device = "/dev/disk/by-uuid/5bf2e86e-cab5-4af1-8d3d-b3b4b1d12af0";
          defaultOptions = ["compress=zstd:1"];
          subvols = {
            "/" = "@";
            "/home" = "@home";
            "/nix" = "@nix";
            "/var/top" = null;
          };

          overrideDefaultOptionsBySubvol = {
            "@nix" = ["compress=zstd:3" "noatime"];
          };
        };
      in
        primaryDrive
        // {
          "/boot" = {
            device = "/dev/disk/by-uuid/0ED5-65AF";
            fsType = "vfat";
            options = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };

      hardware = {
        firmware = [pkgs.linux-firmware];
        cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        bluetooth = {
          enable = true;
          powerOnBoot = true;
        };
      };

      networking.networkmanager.enable = true;

      boot = {
        kernelPackages = pkgs.linuxKernel.packages.linux_6_18;

        initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usbhid"
          "sd_mod"
        ];

        #initrd.kernelModules = [];
        kernelModules = ["kvm-amd"];
        #extraModulePackages = [];
      };

      imports = [(modulesPath + "/installer/scan/not-detected.nix")];
    };

    includes = [
      <sops>

      <hardware/audio>
      <hardware/systemd-boot>

      #<desktop/niri>
      <desktop/sddm>

      <app/steam>
      <app/comma>
    ];
  };
}
