{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    facter.url = "github:nix-community/nixos-facter-modules";
  };

  den.aspects.facter = den.lib.take.exactly ({report}: {
    nixos = {lib, ...}: let
      reportPath = lib.path.append ./. "${report}.json";
    in {
      imports = [inputs.facter.nixosModules.facter];
      facter = {inherit reportPath;};

      assertions = [
        {
          assertion = builtins.pathExists reportPath;
          message = "Facter report ${report} must exist";
        }
      ];
    };
  });
}
