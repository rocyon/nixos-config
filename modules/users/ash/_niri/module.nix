{
  inputs,
  pkgs,
}: {
  config,
  wlib,
  lib,
}: {
  imports = [wlib.wrapperModules.niri];

  settings = {

  };
}
