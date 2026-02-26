{
  __findFile,
  den,
  ...
}: {
  den.aspects.ash = {
    includes =
      (builtins.attrValues den.aspects.ash._)
      ++ [
        <apps/comma>
      ];
  };
}
