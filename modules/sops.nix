{
  __findFile,
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "path:/etc/nixos/secrets";
    };
  };

  den.default.includes = [<sops>]; # import self by default

  den.aspects.sops = let
    sopsFolder = toString inputs.nix-secrets + "/sops";
    sharedSops = "${sopsFolder}/shared.yaml";
  in {
    nixos = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (config.networking) hostName;
    in {
      imports = [inputs.sops-nix.nixosModules.default];

      options.sharedSopsFile = lib.mkOption {
        readOnly = true;
        default = sharedSops;
      };

      config = {
        environment.systemPackages = with pkgs; [sops];

        sops = {
          defaultSopsFile = "${sopsFolder}/host-${hostName}.yaml";
          validateSopsFiles = false;
          age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        };
      };
    };

    darwin = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (config.networking) hostName;
    in {
      imports = [inputs.sops-nix.darwinModules.default];

      options.sharedSopsFile = lib.mkOption {
        readOnly = true;
        default = sharedSops;
      };

      config = {
        environment.systemPackages = with pkgs; [sops];

        sops = {
          defaultSopsFile = "${sopsFolder}/host-${hostName}.yaml";
          validateSopsFiles = false;
          age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        };
      };
    };

    homeManager = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (config) home xdg;
    in {
      imports = [inputs.sops-nix.homeManagerModules.sops];

      options.sharedSopsFile = lib.mkOption {
        readOnly = true;
        default = sharedSops;
      };

      config = {
        home.packages = with pkgs; [sops];
        sops = {
          defaultSopsFile = "${sopsFolder}/user-${home.username}.yaml";
          validateSopsFiles = false;
          age.sshKeyPaths = ["${xdg.configHome}/sops/age/keys.txt"];

          secrets = {
            "public-ssh/${home.username}" = {
              sopsFile = sharedSops;
              path = "${home.homeDirectory}/.ssh/ed25519.pub";
            };

            "private-ssh".path = "${home.homeDirectory}/.ssh/ed25519";
          };
        };
      };
    };

    includes = [
      # per-user configuration of age ownership and user's hashed password
      (den.lib.take.exactly ({
        host,
        user,
      }: {
        # sops-nix creates .config/sops/age as root by default
        # this startup script will change the ownership
        # ref: https://github.com/Mic92/sops-nix/issues/381
        ${host.class} = {config, ...}: {
          system.activationScripts."${user.name}-setSopsKeyOwnership" = let
            # use in-system representation of the user
            this = config.users.users.${user.name};

            configHome = config.home-manager.users.${user.name}.xdg.configHome;
            sopsFolder = "${configHome}/sops";
          in ''
            mkdir -p ${sopsFolder}/age || true
            chown -R ${this.user}:${this.group} ${sopsFolder}
          '';

          sops.secrets = {
            "passwords/${user.name}".sopsFile = sharedSops;
          };

          users.users.${user.name}.hashedPassword =
            config.sops.secrets."passwords/${user.name}";
        };
      }))
    ];
  };
}
