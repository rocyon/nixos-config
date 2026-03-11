{
  inputs,
  lib,
  den,
  ...
}: {
  _module.args = {
    inherit (den.lib) __findFile parametric;
    inherit (inputs) secrets;
  };

  imports = lib.optionals (inputs ? den) [
    (inputs.den.namespace "rocyon" true)
  ];
}
