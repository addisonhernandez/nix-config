{lib, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
  };

  # Facilitate firewall punching
  # networking.firewall.allowedUDPPorts = [41641];
}
