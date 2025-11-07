{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (config.myUtils.tailnet) networkMap;
  mkTailnetNode = service: {
    extraConfig =
      # Caddyfile
      ''
        bind ${networkMap.${service}.bindHosts}
        reverse_proxy :${toString networkMap.${service}.proxiedPort}
      '';
    hostName = builtins.head networkMap.${service}.FQDNs;
    serverAliases = builtins.tail networkMap.${service}.FQDNs;
  };
in
{
  imports = [
    "${inputs.self}/hosts/common/optional/caddy.nix"

    ./audiobookshelf.nix
    ./homepage.nix
    ./jellyfin.nix
    ./lubelogger.nix
  ];

  # [TODO] Move each host to a separate config module
  services.caddy.virtualHosts = lib.genAttrs [
    "jellyseerr"
    "prowlarr"
    "qbittorrent"
    "radarr"
    "sonarr"
  ] mkTailnetNode;

  users.groups.media = {
    gid = 6969;
    members = builtins.filter (user: config.users.users ? ${user}) [
      "audiobookshelf"
      "hotio"
      "jellyfin"
    ];
  };
}
