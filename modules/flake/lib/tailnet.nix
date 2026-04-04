{ lib, ... }:
{
  flake.lib = {
    tailnet =
      let
        magicDNSSuffix = "beefalo-spica.ts.net";
        mkService = hostName: nodeNames: proxiedPort: {
          inherit hostName nodeNames proxiedPort;
          bindHosts = lib.concatMapStringsSep " " (n: "tailscale/${n}") nodeNames;
          FQDNs = map (node: "${node}.${magicDNSSuffix}") nodeNames;
        };
        mkSvcOnJeeves = mkService "jeeves";
      in
      {
        inherit magicDNSSuffix;
        networkMap = {
          audiobookshelf = mkSvcOnJeeves [ "audiobookshelf" ] 8008;
          homepage = mkSvcOnJeeves [ "home" ] 8082;
          jellyfin = mkSvcOnJeeves [ "jellyfin" "media" ] 8096;
          jellyseerr = mkSvcOnJeeves [ "jellyseerr" "requests" ] 5055;
          lubelogger = mkSvcOnJeeves [ "lubelogger" ] 5000;
          prowlarr = mkSvcOnJeeves [ "prowlarr" ] 9696;
          qbittorrent = mkSvcOnJeeves [ "qbittorrent" ] 8080;
          radarr = mkSvcOnJeeves [ "radarr" ] 7878;
          sonarr = mkSvcOnJeeves [ "sonarr" ] 8989;
        };
      };
  };
}
