# The overarching config settings for all hosts
# Contains 'host-spec' settings that have symptoms
let
  defaultUsers = {
    ash = {
      colorscheme = "catppuccin-mocha";
    };
  };
in {
  den.hosts = {
    x86_64-linux.xenia = {
      isGraphical = true;

      users = {
        inherit
          (defaultUsers)
          ash
          ;
      };
    };

    aarch64-linux.azelf = {
      isGraphical = false;

      users = {
        inherit
          (defaultUsers)
          ash
          ;
      };
    };
  };
}
