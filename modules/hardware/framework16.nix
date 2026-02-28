{
  den.aspects.hardware._.framework16.nixos = {
    config,
    lib,
    ...
  }: {
    boot.kernelModules = ["kvm-amd"];
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
    ];

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
