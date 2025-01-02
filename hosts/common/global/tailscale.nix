{ lib, ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
    extraSetFlags = [ "--ssh" ];
  };

  # Facilitate firewall punching
  # networking.firewall.allowedUDPPorts = [41641];
}
