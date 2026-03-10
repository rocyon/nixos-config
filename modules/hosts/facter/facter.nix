{
  den,
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.facter = {
    url = "github:nix-community/nixos-facter-modules";
  };

  den.aspects.facter = report: {
    imports = map den.lib.take.exactly [
      ({host}:
        lib.optionalAttrs (!host.wsl.enable) {
          nixos = {
            modulesPath,
            pkgs,
            ...
          }: {
            imports = [
              (modulesPath + "/installer/scan/not-detected.nix")
            ];

            boot.kernelPackages = with pkgs.linuxKernel;
              lib.mkIf (!host.isThin) packages.linux_zen;
          };
        })
    ];

    nixos = let
      reportPath = lib.path.append ./. "${report}.json";
    in {
      imports = [inputs.facter.nixosModules.facter];

      facter = {inherit reportPath;};
      hardware.enableRedistributableFirmware = true;

      assertions = [
        {
          assertion = builtins.pathExists reportPath;
          message = "Facter report ${report} must exist";
        }
      ];
    };
  };
}
