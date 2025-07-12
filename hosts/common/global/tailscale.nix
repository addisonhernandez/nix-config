{ config, lib, ... }:
{
  services.tailscale = {
    enable = true;

    # [TODO] use sops module to generate authKeyFile path
    authKeyFile = "/run/secrets/services/tailscale/nixos-authkey";

    extraUpFlags = [ "--ssh" ];
    openFirewall = true;

    # client | both => set reverse path filtering to loose
    # server | both => enable IP forwarding
    useRoutingFeatures = lib.mkDefault "client";
  };

  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
}
