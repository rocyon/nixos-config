{
  __findFile,
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nixcord = {
      url = "github:FlameFlag/nixcord";
    };
  };

  den.aspects.ash._.graphical._.discord = {
    homeManager = {
      osConfig,
      config,
      ...
    }: {
      imports = [inputs.nixcord.homeModules.nixcord];

      stylix.targets.nixcord.enable = true;

      programs.nixcord = {
        discord = {
          #branch = "canary";

          #=- clients
          #vencord.eanble = false;
          equicord.enable = true;

            #openASAR.enable = true;
        };

        equibop.enable = true;

        dorion.enable = true;
        dorion = {
          clientMods = ["Shelter" "Equicord"];
        };

        config = {
          autoUpdate = false;
          autoUpdateNotification = false;
          disableMinSize = true;
          frameless = config.programs.niri.enable || osConfig.programs.niri.enable;
          #notifyAboutUpdate = false;

          plugins = {
            AmITyping.enable = true;
            ClearURLs.enable = true;
            CopyUserURLs.enable = true;
          };
        };
      };
    };

    includes =
      [
        #<ash/stylix>
      ]
      ++ (map den.lib.take.atLeast [
        ({vesktop, ...}: {
        })

        ({equibop}: {
        })
      ]);
  };
}
