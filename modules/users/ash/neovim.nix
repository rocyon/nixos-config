{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # These 2 are already in nixpkgs, however this ensures you always fetch the most up to date version!
    plugins-lze = {
      url = "github:BirdeeHub/lze";
      flake = false;
    };

    plugins-lzextras = {
      url = "github:BirdeeHub/lzextras";
      flake = false;
    };
  };

  den.aspects.ash._.neovim.homeManager = {pkgs, ...}: let
    neovim =
      (import ./_neovim/module.nix {inherit inputs pkgs;})
      |> inputs.wrappers.lib.evalModule
      |> (w: w.config.wrap {inherit pkgs;});
  in {
    home.packages = [neovim];
  };
}
