{
  den.aspects.tools._.tailscale = {
    nixos = {
      programs.tailscale = {
        enable = true;
        
        useRoutingFeatures = "both";
      };
    };
  };
}
