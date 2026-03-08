{
  den.aspects.tools._.zoxide = {
    homeManager = {pkgs,...}: {
      home.packages = [pkgs.zoxide];
      programs.zoxide = {
        enable = true;
        options = ["--cmd cd"];
      };
    };
  };
}
