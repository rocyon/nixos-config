{__findFile, ...}: {
  den.aspects.ash._.ssh = {
    includes = [<sops>];

    homeManager = {config, pkgs, ...}: {
      home.packages = [pkgs.fastfetch];
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks = {
          "*".compression = true;

          "codeberg.org" = {
            identityFile = config.sops.secrets."private-ssh".path;
          };
        };
      };
    };
  };
}
