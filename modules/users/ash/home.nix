{
  den.aspects.ash._.home.homeManager = {
    config,
    pkgs,
    ...
  }: let
  in {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    xdg.mime.enable = true;
    xdg.mimeApps.enable = true;
    xdg.userDirs = let
      inherit (config.home) homeDirectory;
    in {
      enable = true;
      createDirectories = true;

      desktop = null;
      publicShare = null;
      templates = null;

      documents = "${homeDirectory}/Documents";
      download = "${homeDirectory}/Tmp";
      music = "${homeDirectory}/Albums";
      pictures = "${homeDirectory}/Media";
      videos = "${homeDirectory}/Media";
    };

    home.shellAliases = {
      l = "ls";
      ll = "ls -l";
      la = "ls -al";
      cd = "z";
      update = "sudo nixos-rebuild switch";
    };

    home.packages = with pkgs; [
      nautilus
      prismlauncher
    ];
  };
}
