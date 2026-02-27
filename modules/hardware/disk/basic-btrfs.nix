{den, ...}: {
  den.aspects.hardware._.disks._.basic-btrfs = den.lib.takes.exactly ({btrfsDevice}: {
    nixos.fileSystems = {
    };
  });
}
