{
  __findFile,
  lib,
  secrets,
  ...
}: {
  den.hosts.x86_64-linux.minior = {
    isGraphical = false;
    isThin = true;

    users.ash.classes = ["homeManager"];
  };

  den.aspects.minior = {
    includes = [
      (<facter> "pyroVPS")
      <hardware/systemd-boot>
    ];

    nixos = {modulesPath, ...}: let
      mkBtrfs = import ../_mkBtrfs.nix {inherit lib;};
    in {
      imports = [(modulesPath + "/profiles/qemu-guest.nix")];
      boot.initrd.availableKernelModules = ["ahci" "virtio_pci" "virtio_scsi" "xhci_pci" "sd_mod" "sr_mod" "virtio_blk"];
      boot.kernelModules = ["kvm-amd"];
      fileSystems =
        {
          "/boot" = {
            device = "/dev/disk/by-uuid/AF21-2EF4";
            fsType = "vfat";
            options = ["fmask=0022" "dmask=0022"];
          };
        }
        // (mkBtrfs {
            device = "/dev/disk/by-uuid/fc2137fa-475a-47a0-8026-b1c13fd23c1f";
            defaultOptions = ["compress" "noatime"];
            optionsBySubvol."@home" = ["compress"];
          } {
            "/" = "@";
            "/home" = "@home";
            "/nix" = "@nix";
            "/var/log" = "@log";
            "/var/lib/machines" = "@machines";
          });

      # pyro VPS requires static IP configuration for nixos
      networking = {
        resolvconf.enable = true;
        nameservers = ["1.1.1.1"];
        interfaces.enp3s0.ipv4.addresses = [
          {
            address = secrets.networking.publicIp.minior;
            prefixLength = 24;
          }
        ];

        defaultGateway = {
          address =
            lib.splitString "." secrets.networking.publicIp.minior
            |> (l: lib.replaceElemAt l 3 "1")
            |> lib.join ".";
          interface = "enp3s0";
        };
      };
    };
  };
}
