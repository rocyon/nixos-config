{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.nixos-wsl = {
    url = "github:nix-community/NixOS-WSL";
  };

  den.aspects.hardware._.wsl = den.lib.take.exactly ({defaultUser}: {
    nixos = {
      imports = [inputs.nixos-wsl.nixosModules.default];
      wsl = {
        inherit defaultUser;
        enable = true;
      };
    };
  });
}
