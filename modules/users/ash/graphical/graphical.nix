{
  den,
  lib,
  parametric,
  ...
}: {
  den.aspects.ash._.graphical = parametric {
    includes = [
      # ({host, ...}: {
      #   includes =
      #     builtins.trace host.isGraphical
      #     lib.optionalAttrs
      #     host.isGraphical
      #     <| lib.attrValues den.aspects.ash._.graphical._;
      # })
    ];
  };
}
