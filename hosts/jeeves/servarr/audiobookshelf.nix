{
  config,
  inputs,
  pkgs,
  ...
}:
{
  services.audiobookshelf = {
    enable = true;
    host = "0.0.0.0";
    port = 8008;
  };
  environment.systemPackages = [
    # [todo] migrate to self.packages
    (pkgs.callPackage "${inputs.self}/pkgs/audiobook-organizer" { })
  ];

  services.caddy.virtualHosts.audiobookshelf =
    let
      inherit (config.myUtils.tailnet.networkMap) audiobookshelf;
    in
    {
      extraConfig =
        # Caddyfile
        ''
          bind ${audiobookshelf.bindHosts}
          reverse_proxy :${toString audiobookshelf.proxiedPort}
        '';
      hostName = builtins.head audiobookshelf.FQDNs;
      serverAliases = builtins.tail audiobookshelf.FQDNs;
    };
}
