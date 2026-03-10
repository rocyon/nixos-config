{lib, ...}: {
  den.aspects.schema._.isGraphical = {host, ...}:
    lib.optionalAttrs host.isGraphical
    {
      homeManager = {
        xdg = {
          enable = true;
          mime.enable = true;
          portal.enable = true;
        };
      };
    };
}
