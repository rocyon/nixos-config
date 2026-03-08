{
  __findFile,
  lib,
  ...
}: {
  den.aspects.schema._.isSlim = {host, ...}: {
    includes = lib.optionals (!host.isSlim) [
      <tools/yazi>
      <tools/zoxide>
      <tools/comma>
    ];
  };
}
