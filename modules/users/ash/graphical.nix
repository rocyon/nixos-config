{den, ...}: {
  den.aspects.ash._.graphical = den.lib.take.exactly ({host}: {
    includes =
      if host.isGraphical or false
      then [builtins.attrValues den.aspects.ash._.graphical._]
      else [];
  });
}
