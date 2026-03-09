{
  den,
  inputs,
  lib,
  ...
}: {
  _module.args = {
    inherit (den.lib) __findFile parametric;
    inherit (inputs) secrets;
  };

  den.default.nixos = {
    pkgs,
    lib,
    ...
  }: {
    services.openssh.enable = true;
    system = {
      stateVersion = lib.mkDefault "25.05";
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

    security.pam.sshAgentAuth.enable = true;
  };

  den.default.darwin = {};

  den.default.homeManager = {lib, ...}: {
    programs.home-manager.enable = true;

    home = {
      stateVersion = lib.mkDefault "25.05";
      preferXdgDirectories = true;
    };
  };

  # AA Batteries /ref
  den.default.includes = with den._; [
    define-user
    primary-user # causes all users to be wheel, fine for now
    inputs'
    self'
    hostname

    # DOCS: default.includes is evaluated at every stage
    #       take.exactly limits the runnable context
    (den.lib.take.exactly ({host}:
      lib.optionalAttrs (!host.wsl.enable) {
        nixos = {
          lib,
          modulesPath,
          pkgs,
          ...
        }: {
          networking.networkmanager.enable = true;
          imports = [(modulesPath + "/installer/scan/not-detected.nix")];

          hardware.firmware = [pkgs.linux-firmware];
          boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_zen;
        };
      }))
  ];

  den.ctx.hm-host = {
    nixos.home-manager = {
      useGlobalPkgs = true;
      backupFileExtension = "hm-bk";
    };
  };
}
