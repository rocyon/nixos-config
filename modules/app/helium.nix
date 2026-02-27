{...}: {
  den.aspects.app._.helium = {
    nixos = {pkgs,...}: {
      environment.systemPackages = [pkgs.nur.repos.Ev357.helium];
    };
  };
}
