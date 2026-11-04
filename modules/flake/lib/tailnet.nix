{ lib, ... }:
let
  DNSName = "beefalo-spica.ts.net";
  mkTailnetSvc =
    {
      host,
      nodeNames,
      proxiedPort,
    }:
    let
      bindHosts = lib.concatMapStringsSep " " (n: "tailscale/${n}") nodeNames;
      FQDNs = map (node: "${node}.${DNSName}") nodeNames;
    in
    {
      inherit
        bindHosts
        FQDNs
        host
        nodeNames
        proxiedPort
        ;
      hostName = builtins.head FQDNs;
      serverAliases = builtins.tail FQDNs;
      extraConfig =
        # Caddyfile
        ''
          bind ${bindHosts}
          reverse_proxy :${proxiedPort}
        '';
    };
  mkService =
    host: nodeNames: proxiedPort:
    mkTailnetSvc { inherit host nodeNames proxiedPort; };

  # cfg = config.networking.tailnet;
in
{
  flake.lib.tailnet = {
    inherit DNSName;
    networkMap = {
      # Jeeves
      audiobookshelf = mkService "jeeves" [ "audiobookshelf" ] 8008;
      homepage = mkService "jeeves" [ "home" ] 8082;
      jellyfin = mkService "jeeves" [ "jellyfin" "media" ] 8096;
      lubelogger = mkService "jeeves" [ "lubelogger" ] 5000;
      prowlarr = mkService "jeeves" [ "prowlarr" ] 9696;
      qbittorrent = mkService "jeeves" [ "qbittorrent" ] 8080;
      radarr = mkService "jeeves" [ "radarr" ] 7878;
      seerr = mkService "jeeves" [ "seerr" "requests" ] 5055;
      sonarr = mkService "jeeves" [ "sonarr" ] 8989;

      # Vulcan
      immich = mkService "vulcan" [ "immich" "images" ] 2283;
      redlib = mkService "vulcan" [ "redlib" "reddit" ] 8069;
    };
  };
}
