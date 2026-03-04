{
  __findFile,
  inputs,
  ...
}: {
  den.aspects.ash._.ssh = {
    includes = [(<sops> {})];

    homeManager = {
      config,
      pkgs,
      ...
    }: {
      home.packages = [pkgs.fastfetch];

      sops.secrets."private-ssh" = {};

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks = {
          "*".compression = true;

          "codeberg.org" = {
            #addKeysToAgent = "confirm";
            identityFile = config.sops.secrets."private-ssh".path;
          };
        };
      };
    };
  };
}
