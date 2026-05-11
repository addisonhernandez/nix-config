{
  config,
  inputs,
  lib,
  ...
}:
let
  mkTailnetNode = service: {
    inherit (inputs.self.lib.tailnet.networkMap.${service})
      extraConfig
      hostName
      serverAliases
      ;
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
