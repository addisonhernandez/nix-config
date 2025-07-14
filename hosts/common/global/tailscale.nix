{
  config,
  inputs,
  lib,
  ...
}:
{
  services.tailscale = {
    enable = true;

    authKeyFile = config.age.secrets.tailscaleNixosAuthkey.path;

    extraUpFlags = [ "--ssh" ];
    openFirewall = true;

    # client | both => set reverse path filtering to loose
    # server | both => enable IP forwarding
    useRoutingFeatures = lib.mkDefault "client";
  };

  age.secrets.tailscaleNixosAuthkey.file = "${inputs.secrets}/services/tailscale/nixos-authkey.age";

  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
}
