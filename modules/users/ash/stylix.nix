{inputs, ...}: {
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.ash._.stylix.homeManager = {config, pkgs, lib, ...}: {
    imports = [inputs.stylix.homeModules.stylix];
    stylix = {
      enable = true;
      #image = ../../../assets/wallpapers/catppuccin-galaxy.png;
      #polarity = "dark"; # not needed if base16 specified
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };
  };

  #den.aspects.ash._.stylix.includes = [];
}
