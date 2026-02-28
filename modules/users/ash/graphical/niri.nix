{
  __findFile,
  inputs,
  ...
}: {
  den.aspects.ash._.graphical._.niri.includes = [<desktop/niri>];

  den.aspects.ash._.graphical._.niri.homeManager = {
    lib,
    osConfig,
    config,
    pkgs,
    ...
  }: {
    imports = [
      # inputs.niri.homeModules.niri
      inputs.niri.homeModules.stylix
    ];

    xdg.configFile."mimeapps.list".force = true;
    xdg.configFile."ghostty/config".force = true;
    xdg.configFile."gtk-3.0/gtk.css".force = true;
    xdg.configFile."gtk-4.0/gtk.css".force = true;

    stylix.targets.niri.enable = true;

    programs.niri.package = osConfig.programs.niri.package;

    programs.niri.settings = {
      environment."NIXOS_OZONE_WL" = "1";

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
      clipboard.disable-primary = true;

      screenshot-path = "${config.xdg.userDirs.pictures}/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      window-rules = [
        {
          geometry-corner-radius =
            lib.genAttrs
            ["bottom-left" "bottom-right" "top-left" "top-right"]
            (_: 12.0);
          clip-to-geometry = true;
        }
      ];

      layout = {
        gaps = 10;

        center-focused-column = "never";

        default-column-width.proportion = 0.5;
        preset-column-widths = [
          {proportion = 1. / 3.;}
          {proportion = 1. / 2.;}
          {proportion = 2. / 3.;}
        ];

        preset-window-heights = [
          {proportion = 1. / 3.;}
          {proportion = 1. / 2.;}
          {proportion = 2. / 3.;}
        ];

        focus-ring = {
          width = 2;
        };

        shadow = {
          enable = true;
          softness = 30;
          spread = 5;
        };
      };

      binds = {
        "Mod+Slash".action.show-hotkey-overlay = [];
        "Mod+Shift+Slash".action.show-hotkey-overlay = [];
        "Mod+Ctrl+Slash".action.show-hotkey-overlay = [];

        # Application shortcuts
        "Mod+Return".action.spawn = "ghostty";
        "Mod+D".action.spawn = "fuzzel";
        "Mod+B".action.spawn = "helium";
        "Mod+Z".action.spawn = "zen";
        "Mod+E".action.spawn = "dolphin";

        "Mod+Return".hotkey-overlay.title = "Open a Terminal: ghostty";
        "Mod+D".hotkey-overlay.title = "Run an Application: fuzzel";
        "Mod+B".hotkey-overlay.title = "Open a Browser: helium";
        "Mod+Z".hotkey-overlay.title = "Open a Browser: Zen";
        "Mod+E".hotkey-overlay.title = "Open an Application: Dolphin";

        # Media and brightness
        #"XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
        #"XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
        #"XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        #"XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
        "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
        "XF86AudioNext".action.spawn = ["playerctl" "next "];
        "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
        #"XF86MonBrightnessUp".action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];
        #"XF86MonBrightnessDown".action.spawn = ["brightnessctl" "--class=backlight" "set" "10%-"];

        #"XF86AudioRaiseVolume".allow-when-locked = true;
        #"XF86AudioLowerVolume".allow-when-locked = true;
        #"XF86AudioMute".allow-when-locked = true;
        #"XF86AudioMicMute".allow-when-locked = true;
        "XF86AudioPlay".allow-when-locked = true;
        "XF86AudioNext".allow-when-locked = true;
        "XF86AudioPrev".allow-when-locked = true;
        #"XF86MonBrightnessUp".allow-when-locked = true;
        #"XF86MonBrightnessDown".allow-when-locked = true;

        # Window management binds
        "Mod+O".action.toggle-overview = [];
        "Mod+Q".action.close-window = [];

        "Mod+O".repeat = false;
        "Mod+Q".repeat = false;

        "Mod+H".action.focus-column-left = [];
        "Mod+J".action.focus-window-or-workspace-down = [];
        "Mod+K".action.focus-window-or-workspace-up = [];
        "Mod+L".action.focus-column-right = [];

        "Mod+Ctrl+H".action.move-column-left = [];
        "Mod+Ctrl+J".action.move-window-down-or-to-workspace-down = [];
        "Mod+Ctrl+K".action.move-window-up-or-to-workspace-up = [];
        "Mod+Ctrl+L".action.move-column-right = [];

        "Mod+Shift+H".action.focus-monitor-left = [];
        "Mod+Shift+J".action.focus-monitor-down = [];
        "Mod+Shift+K".action.focus-monitor-up = [];
        "Mod+Shift+L".action.focus-monitor-right = [];

        "Mod+Ctrl+Shift+H".action.move-column-to-monitor-left = [];
        "Mod+Ctrl+Shift+J".action.move-column-to-monitor-down = [];
        "Mod+Ctrl+Shift+K".action.move-column-to-monitor-up = [];
        "Mod+Ctrl+Shift+L".action.move-column-to-monitor-right = [];

        # Consume & expel
        #"Mod+Comma".action.consume-or-expel-window-left = [];
        "Mod+Period".action.consume-or-expel-window-right = [];

        # Resize
        "Mod+R".action.switch-preset-column-width = [];
        "Mod+Shift+R".action.switch-preset-window-height = [];
        "Mod+Ctrl+R".action.reset-window-height = [];

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Fullscreen & Maximize
        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];
        "Mod+Ctrl+F".action.expand-column-to-available-width = [];

        # Center
        "Mod+C".action.center-column = [];
        "Mod+Ctrl+C".action.center-visible-columns = [];

        # Floating
        #"Mod+V".action.toggle-window-floating = [];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

        # Tabbed
        "Mod+W".action.toggle-column-tabbed-display = [];

        # Screenshot
        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
        "Alt+Print".action.screenshot-window = [];

        # RDP escape
        "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = [];
        "Mod+Escape".allow-inhibiting = false;

        # The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Shift+E".action.quit.skip-confirmation = false;
        "Ctrl+Alt+Delete".action.quit.skip-confirmation = true;

        # Power off monitors
        "Mod+Alt+P".action.power-off-monitors = [];
      };

      # Outputs handled by DMS
      # outputs = let
      #   size = height: width: {inherit height width;};
      #   pos = x: y: {inherit x y;};
      # in {
        # Cheap
        # "GIGA-BYTE TECHNOLOGY CO., LTD. G27FC 0x000024C5" = {
        #   mode = size 1920 1080;
        #   scale = 1;
        #   position = pos (-1920) 0;
        # };

        # Portable 1080p
        # "PNP(GWD) ARZOPA 000000000000" = {
        #   mode = size 1920 1080;
        #
        #   scale = 1;
        #     #position = pos 1920 1600;
        #   position = pos 0 1028;
        # };
        #
        # # Fancy
        # "hisense electric co., ltd. 6series65 0x00000502" = {
        #   mode = size 2560 1440;
        #   scale = 1;
        #   position = pos 2048 0;
        # };
        #
        # # Internal fw16
        # "BOE 0x0BC9 Unknown" = {
        #   mode = size 2560 1600;
        #   scale = 1.25;
        #   position = pos 0 0;
        # };
      # };

      input = {
        mouse = {
          accel-speed = 0.3;
          accel-profile = "flat";
        };
        keyboard.numlock = true;

        focus-follows-mouse.enable = true;
        focus-follows-mouse.max-scroll-amount = "40%";
      };

      xwayland-satellite = {
        enable = true;
        path = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      };
    };
  };
}
