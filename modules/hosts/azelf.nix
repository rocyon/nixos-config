{__findFile, ...}: {
  den.aspects.azelf = {
    includes = [
      (<facter> {report = "Wsl-MsSurface7";})
      (<hardware/wsl> {defaultUser = "ash";})
    ];
  };
}
