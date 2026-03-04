{
  __findFile,
  den,
  inputs,
  lib,
  ...
}: {
  flake-file.inputs = {
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {url = "path:/etc/nixos/secrets";};
  };

  # import self by default
  den.default.includes = [(<sops> {})];

  den.aspects.sops = {
    input ? inputs.secrets,
    sopsFolder ? "${toString input}/sops",
    sharedFile ? "shared.yaml",
    hostFile ? (name: "host-${name}.yaml"),
    userFile ? (name: "user-${name}.yaml"),
  }: let
    sharedPath = "${sopsFolder}/${sharedFile}";
    hostPath = name: "${sopsFolder}/${hostFile name}";
    userPath = name: "${sopsFolder}/${userFile name}";

    sharedSopsFile = lib.mkOption {
      readOnly = true;
      default = sharedPath;
    };
  in
    den.lib.parametric
    <| (attrs: {includes = [attrs];})
    <| #=~ Configure Sops
    ({
      host,
      user,
      ...
    }: {
      ${host.class} = {
        config,
        pkgs,
        ...
      }: {
        imports = [inputs.sops-nix."${host.class}Modules".default];

        options.sops = {inherit sharedSopsFile;};

        config = {
          environment.systemPackages = [pkgs.sops];

          # sops-nix creates .config/sops/age as root by default
          # this startup script will change the ownership
          # ref: https://github.com/Mic92/sops-nix/issues/381
          system.activationScripts."${user.name}-setSopsKeyOwnership" = let
            this = config.users.users.${user.name};
            configHome = config.home-manager.users.${user.name}.xdg.configHome;
            sopsFolder = "${configHome}/sops";
          in ''
            mkdir -p ${sopsFolder}/age || true
            chown -R ${this.name}:${this.group} ${sopsFolder}
          '';

          sops = {
            age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
            defaultSopsFile = hostPath host.name;
            validateSopsFiles = false;
            secrets = {
              "passwords/${user.name}".sopsFile = config.sops.sharedSopsFile;
            };
          };

          users.users.${user.name}.hashedPasswordFile =
            config.sops.secrets."passwords/${user.name}".path;
        };
      };

      homeManager = {
        config,
        pkgs,
        ...
      }: {
        imports = [inputs.sops-nix.homeModules.sops];

        options.sops = {inherit sharedSopsFile;};

        config = {
          home.packages = [pkgs.sops];
          sops = {
            age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
            defaultSopsFile = userPath user.name;
          };
        };
      };
    });
}
