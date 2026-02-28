{__findFile, ...}: {
  den.aspects.azelf = {
    includes = [
      (<hardware/wsl> {defaultUser = "ash";})
    ];
  };
}
