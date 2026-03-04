{
  den.aspects.app._.jujutsu = {
    email,
    name,
  }: {
    homeManager = {config, ...}: {
      programs.jujutsu = {
        enable = true;

        settings.user = {inherit email name;};

        settings.ui = {
          editor = config.home.sessionVariables.EDITOR;
          default-command = ["log" "--summary"];
        };

        settings.aliases = {
          clone = ["git" "clone"];
          fetch = ["git" "fetch"];
          init = ["git" "init"];
          push = ["git" "push"];
          stat = ["log" "--stat"];
        };
      };
    };
  };
}
