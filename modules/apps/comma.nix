{inputs, ...}: {
  flake-file.inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.apps._.comma = with inputs.nix-index-database; {
    nixos = {
      imports = [nixosModules.default];
      programs.nix-index-database.comma.enable = true;
    };

    darwin = {
      imports = [darwinModules.nix-index];
      programs.nix-index-database.comma.enable = true;
    };

    # homeManager = {
    #   imports = [homeManagerModules.default];
    #   programs.nix-index-database.comma.enable = true;
    # };
  };
}
