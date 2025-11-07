{ config, ... }:
let
  inherit (config.myUtils.tailnet.networkMap) lubelogger;
in
{
  services = {
    lubelogger.enable = true;
    caddy.virtualHosts.lubelogger = {
      extraConfig =
        # Caddyfile
        ''
          bind ${lubelogger.bindHosts}
          reverse_proxy :${toString lubelogger.proxiedPort}
        '';
      hostName = builtins.head lubelogger.FQDNs;
      serverAliases = builtins.tail lubelogger.FQDNs;
    };
  };
}
