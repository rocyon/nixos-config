{
  den.aspects.ash._.jujutsu = {
    homeManager = {config, ...}: {
      programs.jujutsu.enable = true;
      programs.jujutsu.settings = {
        user = {
          email = "rocyon@pm.me";
          name = "rocyon";
        };

        ui = {
          editor = config.home.sessionVariables.EDITOR or "nvim";
          default-command = "log";
        };
      }; # settings
    }; # homeManager
  };
}
