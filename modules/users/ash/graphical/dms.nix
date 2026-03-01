{inputs, ...}: {
  flake-file.inputs = {
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #session.isLightMode = false;
  };

  den.aspects.ash._.graphical._.dms.homeManager = {lib, ...}: let
    Mb = b: b * 1024 * 1024;
  in {
    imports = with inputs; [
      dms.homeModules.dank-material-shell
      dms.homeModules.niri
      dms-plugin-registry.modules.default
    ];

    programs.dank-material-shell = {
      enable = true;

      clipboardSettings = {
        disabled = false;

        autoClearDays = 90;
        clearAtStartup = false;
        maxEntrySize = Mb 5;
        maxHistory = 100;
        maxPinned = 25;
      };

      settings = let
        logoMode = "os"; # os|compositor|
        customLogoPath = "";
      in {
        use24HourClock = true;
        useFahrenheit = false;

        transparency = 0.0;
        widgetTransparency = 1.0;

        #=- Dock
        showDock = true;
        dockTransparency = lib.mkForce 0.75;
        dockIsolateDisplays = true;
        dockSmartAutoHide = true;
        dockOpenOnOverview = true;
        dockLauncherLogoMode = "os";
        dockIndicatorStyle = "line";

        #=- Launcher
        launcherLogoMode = "os";
        launcherLogoCustomPath = "";

        dankLauncherV2Size = "compact";
      };

      niri.enableSpawn = true;
      niri.includes.enable = true;
      niri.includes.filesToInclude = [
        "alttab"
        "binds"
        "colors"
        "cursor"
        "layout"
        "outputs"
        "wpblur"
        "windowrules"
      ];

      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = true; # VPN management widget

      plugins = {
        dankBatteryAlerts.enable = true;
      };
    };
  };

  den.aspects.ash._.graphical._.dms.nixos = {
    # https://danklinux.com/docs/dankmaterialshell/nixos-flake#polkit-agent
    systemd.user.services.niri-flake-polkit.enable = false;
  };
}
