{lib}: {
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
})
