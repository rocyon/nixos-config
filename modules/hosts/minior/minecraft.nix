{secrets, ...}: {
  den.aspects.minior._.minecraft = {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = true;
    whitelist = secrets.services.minecraftWhitelist;
  };
}
