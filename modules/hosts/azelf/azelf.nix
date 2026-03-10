{__findFile, ...}: {
  den.aspects.azelf = {
    includes = [
      (<facter>  "Wsl-MsSurface7")
      (<hardware/wsl> {defaultUser = "ash";})
    ];
  };
}
