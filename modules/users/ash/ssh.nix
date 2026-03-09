{
  __findFile,
  inputs,
  secrets,
  ...
}: {
  den.aspects.ash._.ssh = {
    homeManager = {
      config,
      pkgs,
      ...
    }: {
      home.packages = [pkgs.fastfetch];

      sops.secrets = {
        "private-ssh" = {};
        "key-opal" = {};
      };

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks = {
          "*".compression = true;
          "*".identityFile = config.sops.secrets."key-opal".path;

          "minior".hostname = secrets.networking.publicIp.minior;
          "xenia" = {};
        };
      };
    };
  };
}
