{
  den.aspects.tools._.tailscale = {
    nixos = {
      services.tailscale = {
        enable = true;
        
        useRoutingFeatures = "both";
      };
    };
  };
}
