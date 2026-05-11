{ inputs, ... }:
{
  services.lubelogger.enable = true;
  services.caddy.virtualHosts.lubelogger = {
    inherit (inputs.self.lib.tailnet.networkMap.lubelogger)
      extraConfig
      hostName
      serverAliases
      ;
  };
}
