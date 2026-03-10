{
  den,
  lib,
  ...
}: {
  den.aspects.ash._.graphical = {
    includes = [
      ({host, ...}: {
        includes =
          lib.optionals
          host.isGraphical
          <| lib.attrValues den.aspects.ash._.graphical._;
      })
    ];
  };
}
