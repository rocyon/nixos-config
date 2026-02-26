{__findFile, ...}: {
  den.hosts.aarch64-linux.azelf.users = {
    ash = {};
    aurora = {};
  };

  den.aspects.aurora.includes = [ ];

  den.aspects.azelf = {
    includes = [
      (<hardware/wsl> {defaultUser = "ash";})
    ];
  };
}
