{ config, lib, ... }:
let
  inherit (lib) types;
  cfg = config.myUtils.tailnet;

  networkMapType.options = {
    hostName = lib.mkOption { type = types.str; };
    nodeNames = lib.mkOption { type = types.listOf types.str; };
    proxiedPort = lib.mkOption { type = types.port; };
    bindHosts = lib.mkOption { type = types.str; };
    FQDNs = lib.mkOption { type = types.listOf types.str; };
  };

  mkService = hostName: nodeNames: proxiedPort: {
    inherit hostName nodeNames proxiedPort;
    bindHosts = lib.concatMapStringsSep " " (n: "tailscale/${n}") nodeNames;
    FQDNs = map (node: "${node}.${cfg.magicDNSSuffix}") nodeNames;
  };
  mkSvcOnJeeves = mkService "jeeves";
in
{
  options.myUtils.tailnet = {
    magicDNSSuffix = lib.mkOption {
      type = types.strMatching "[[:lower:]]+-[[:lower:]]+\.ts\.net";
      description = "Tailnet name";
      default = "beefalo-spica.ts.net";
      example = "pango-lin.ts.net";
    };

    networkMap = lib.mkOption {
      type = types.attrsOf (types.submodule networkMapType);
      description = "Hostnames, ports, and FQDNs for services on ${cfg.magicDNSSuffix}";
      default = {
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
