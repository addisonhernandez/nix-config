{ inputs, ... }:
{
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
  };

  services.caddy.virtualHosts.immich =
    let
      inherit (inputs.self.lib.tailnet.networkMap) immich;
    in
    {
      extraConfig =
        # Caddyfile
        ''
          bind ${immich.bindHosts}
          reverse_proxy :${toString immich.proxiedPort}
        '';
      hostName = builtins.head immich.FQDNs;
      serverAliases = builtins.tail immich.FQDNs;
    };
}
