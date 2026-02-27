{
  __findFile,
  den,
  ...
}: {
  den.aspects.ash = {
    includes =
      (builtins.attrValues den.aspects.ash._)
      ++ [
        <app/comma>
        <app/helium>
      ];

    homeManager = {
      config,
      pkgs,
      ...
    }: let
      inherit (config.home) homeDirectory;
    in {
      xdg = {
        userDirs = {
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

        mime.enable = true;
        mimeApps.enable = true;
      };

      programs = {
        ghostty.enable = true;
        mpv.enable = true;
        zoxide.enable = true;
        yazi.enable = true;
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
      ];
    };
  };
}
