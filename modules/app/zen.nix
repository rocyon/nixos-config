{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.app._.zen = {
    homeManager = {pkgs, ...}: {
      imports = [inputs.zen-browser.homeModules.twilight];

      programs.zen-browser = {
        nativeMessagingHosts = [pkgs.firefoxpwa];

        policies = {
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Cryptomining = true;
            Fingerprinting = true;
            Locked = true;
            Value = true;
          };
        };

        profiles.default = {
          mods = [
            "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better unloaded tabs
          ];

          search = {
            force = true;
            default = "ddg";
            engines.unduck = {
              name = "unduck";
              urls = [
                {
                  template = "https://unduck.link?q=%s";
                  params = [
                    {
                      name = "query";
                      value = "%s";
                    }
                  ];
                }
              ];

              icon = "";
              definedAliases = ["und"];
            };
          };
        }; #profiles
      };
    };

    includes = [
      (den.lib.take.exactly ({host}: {
        homeManager.programs.zen-browser.profiles.default = {
          extensions.packages = with inputs.firefox-addons.packages.${host.system}; [
            ublock-origin
            proton-pass
            proton-vpn
            dark-reader
          ];
        }; #homeManager
      }))
    ];
  };
}
