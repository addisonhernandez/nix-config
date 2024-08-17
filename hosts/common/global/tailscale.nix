{lib, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
    authKeyFile = /etc/tailscale/keyfile;
    extraUpFlags = ["--ssh"];
    extraSetFlags = ["--ssh"];
  };

  # Facilitate firewall punching
  # networking.firewall.allowedUDPPorts = [41641];
}
