{ inputs, ... }:
{
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
  };

  services.caddy.virtualHosts.immich = {
    inherit (inputs.self.lib.tailnet.networkMap.immich)
      extraConfig
      hostName
      serverAliases
      ;
  };
}
