{
  lib,
  pkgs,
}: {
  config.vim = {
    theme.enable = true;


    languages = {
      nix.enable = true;
      rust.enable = true;
    };
  };
}
