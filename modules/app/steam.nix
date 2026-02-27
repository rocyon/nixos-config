{__findFile, ...}: {
  den.aspects.app._.steam = {
    nixos = {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = false;
        localNetworkGameTransfers.openFirewall = true;
      };
    };

    provides.gamescope = let
      gamescopeArgs = [
        #"--mangoapp"
        "-e"
        "-w 1920"
        "-h 1080"
        "-f"
      ];

      steamArgs = [
        "-tenfoot"
        "-pipwire-dmabuf"
        "-steamos3"
      ];
    in {
      includes = [<app/steam>];

      nixos = {
        pkgs,
        lib,
        ...
      }: let
        scriptBin = pkgs.writeShellScriptBin;

        gamescope-session = scriptBin "gamescope-session" ''
          MANGOAPP_FLAG=""

          if command -v mangoapp &> /dev/null;
          then
              MANGOAPP_FLAG="--mangoapp"
          else
              printf "[%s] [Info] 'mangoapp' is not available on your system. Check to see that MangoHud is installed.\n" "$0"
              printf "[%s] [Info] Continuing without the '--mangoapp' flag.\n" "$0"
          fi

          gamescope $MANGOAPP_FLAG ${lib.concatStringsSep " " gamescopeArgs} -- \
              steam ${lib.concatStringsSep " " steamArgs}
        '';

        jupiter-biosupdate = scriptBin "juniper-biosupdate" ''
          echo "No updates configured for this bios"
          exit 0;
        '';

        steamos-select-branch = scriptBin "steamos-select-branch" ''
          echo "Not applicable for this OS"
        '';

        steamos-session-select = scriptBin "steamos-session-select" ''
          steam -shutdown
        '';

        steamos-update = scriptBin "steamos-update" ''
          exit 7;
        '';

        steamos-set-timezone = scriptBin "steamos-set-timezone" ''
          exit 0;
        '';

        gamescopeDesktop = pkgs.makeDesktopItem {
          name = "Steam (gamescope session)";
          desktopName = "gamescope";
          comment = "Run Steam directly in Gamescope";
          genericName = "Steam Gamescope";
          exec = "gamescope-session";
          #type = "Application"; # default
        };

        pollkitJupiter-biosupdate = scriptBin "steamos-polkit-helpers/jupiter-biosupdate" ''
          set -eu
          exec ${jupiter-biosupdate} "$0"
        '';

        pollkitSteamos-set-timezone = scriptBin "steamos-polkit-helpers/steamos-set-timezone" ''
          exit 0;
        '';

        pollkitSteamos-update = scriptBin "steamos-polkit-helpers/steamos-update" ''
          set -eu
          exec ${steamos-update} "$0"
        '';
      in {
        environment.systemPackages = [
          gamescope-session
          jupiter-biosupdate
          steamos-select-branch
          steamos-session-select
          steamos-update
          steamos-set-timezone

          gamescopeDesktop

          pollkitJupiter-biosupdate
          pollkitSteamos-set-timezone
          pollkitSteamos-update

          pkgs.mangohud
        ];

        hardware.graphics = {
          extraPackages = with pkgs; [mangohud];
          extraPackages32 = with pkgs; [mangohud];
        };

        systemd.tmpfiles.rules = [
          "L+ /usr/bin/gamescope-session - - - - ${gamescope-session}"
          "L+ /usr/bin/jupiter-biosupdate - - - - ${jupiter-biosupdate}"
          "L+ /usr/bin/steamos-select-branch - - - - ${steamos-select-branch}"
          "L+ /usr/bin/steamos-session-select - - - - ${steamos-session-select}"
          "L+ /usr/bin/steamos-update - - - - ${steamos-update}"
          "L+ /usr/bin/steamos-set-timezone - - - - ${steamos-set-timezone}"
          "L+ /usr/bin/steamos-polkit-helpers/jupiter-biosupdate - - - - ${pollkitJupiter-biosupdate}"
          "L+ /usr/bin/steamos-polkit-helpers/steamos-set-timezone - - - - ${pollkitSteamos-set-timezone}"
          "L+ /usr/bin/steamos-polkit-helpers/steamos-update - - - - ${pollkitSteamos-update}"
        ];

        # FIXME
        #security.pam.services.kde.kwallet.forceRun = true;

        programs.steam = {
          gamescopeSession = {
            enable = true;
            args = gamescopeArgs;
            steamArgs = steamArgs;
          };

          extraCompatPackages = with pkgs; [proton-ge-bin];
        };

        programs.gamescope = {
          enable = true;
          capSysNice = true;
        };

        hardware.xone.enable = false; # support for the xbox controller USB dongle

        # some games distribute as appimages
        programs.appimage.enable = true;
        programs.appimage.binfmt = true;
      }; #nixos
    }; #gamescope
  };
}
