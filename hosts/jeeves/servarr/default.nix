{
  config,
  inputs,
  outputs,
  lib,
  ...
}:
let
  mkTailnetNode = outputs.lib.mkTailnetNode config;
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
    members = builtins.filter (user: config.users.users ? user) [
      "audiobookshelf"
      "hotio"
      "jellyfin"
    ];
  };
}
