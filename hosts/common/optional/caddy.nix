{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.caddy = {
    enable = true;

    # [TODO] use sops module to set enenvironmentFile path
    environmentFile = "/run/secrets/caddy.env";

    globalConfig =
      # Caddyfile
      ''
        tailscale {
          ephemeral true
          auth_key {$TS_AUTHKEY}
        }
      '';

    package = pkgs.caddy.withPlugins {
      plugins = [
        # See: https://wiki.nixos.org/wiki/Caddy#Plug-ins for plugin version tag
        "github.com/tailscale/caddy-tailscale@v0.0.0-20250508175905-642f61fea3cc"
      ];
      hash = [ "sha256-K4K3qxN1TQ1Ia3yVLNfIOESXzC/d6HhzgWpC1qkT22k=" ];
    };

    # [TODO] Move each host to a separate config module
    virtualHosts =
      let
        mkTailnetNode =
          {
            nodeNames,
            proxyPort,
            magicDNSSuffix ? "beefalo-spica.ts.net",
          }:
          let
            bindHosts = lib.concatMapStringsSep " " (n: "tailscale/${n}") nodeNames;
            FQDNs = map (alias: "${alias}.${magicDNSSuffix}") nodeNames;
          in
          {
            extraConfig =
              # Caddyfile
              ''
                bind ${bindHosts}
                reverse_proxy :${toString proxyPort}
              '';
            hostName = builtins.head FQDNs;
            serverAliases = builtins.tail FQDNs;
          };
      in
      {
        "jellyseerr" = mkTailnetNode {
          nodeNames = [
            "jellyseerr"
            "requests"
          ];
          proxyPort = 5055;
        };
        "prowlarr" = mkTailnetNode {
          nodeNames = [
            "prowlarr"
            "indexers"
          ];
          proxyPort = 9696;
        };
        "qbittorrent" = mkTailnetNode {
          nodeNames = [
            "qbittorrent"
            "torrents"
          ];
          proxyPort = 8080;
        };
        "radarr" = mkTailnetNode {
          nodeNames = [
            "radarr"
            "movies"
          ];
          proxyPort = 7878;
        };
        "sonarr" = mkTailnetNode {
          nodeNames = [
            "sonarr"
            "shows"
          ];
          proxyPort = 8989;
        };
      };
  };

  services.tailscale.permitCertUid = toString config.users.users.caddy.uid;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
