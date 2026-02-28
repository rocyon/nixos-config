{
  den,
  inputs,
  ...
}: {
  _module.args.__findFile = den.lib.__findFile;

  den.default.nixos = {
    pkgs,
    lib,
    ...
  }: {
    system.stateVersion = "25.05";

    home-manager = {
      useGlobalPkgs = true;
      backupFileExtension = "hm-bk";
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

    environment = {
      enableAllTerminfo = true;
      localBinInPath = true;
      systemPackages = with pkgs; [openssh git jujutsu];
    };

    hardware.enableRedistributableFirmware = true;

    security.sudo.extraConfig = ''
      Defaults lecture = never
      Defaults pwfeedback
      Defaults timestamp_timeout=120
      Defaults env_keep+=SSH_AUTH_SOCK
    '';

    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
    time.timeZone = lib.mkDefault "America/Chicago";

    nix.settings = {
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      warn-dirty = false;
      trusted-users = ["@wheel"];
      fallback = true;

      substituters = [
        "https://cache.nixos.org" # Official global cache
        "https://nix-community.cachix.org" # Community packages
      ];

      extra-substituters = [
        "https://nix-community.cachix.org" # Nix community Cachix server
      ];

      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    zramSwap = {
      enable = true;
      memoryPercent = 90;
    };

    imports = [
      inputs.nur.modules.nixos.default
    ];
  };

  den.default.darwin = {};

  den.default.homeManager = {lib, ...}: {
    programs.home-manager.enable = true;

    home = {
      stateVersion = lib.mkDefault "25.05";
      preferXdgDirectories = true;
    };
  };

  den.default.includes = with den; [
    _.define-user
    _.primary-user # causes all users to be wheel
    _.inputs'
    _.self'

    (lib.take.exactly ({host}: {
      nixos = {config, ...}: {
        networking.hostName = host.name;
      };
    }))

    # defaults that disable if nixos-wsl is enabled
    {
      nixos = {
        lib,
        modulesPath,
        pkgs,
        ...
      }:
        lib.optionalAttrs (true) {
          networking.networkmanager.enable = true;
          imports = [(modulesPath + "/installer/scan/not-detected.nix")];

          hardware.firmware = [pkgs.linux-firmware];
          boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_zen;
        };
    }
  ];
}
