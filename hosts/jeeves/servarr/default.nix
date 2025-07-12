{ config, inputs, ... }:
{
  imports = [
    "${inputs.self}/hosts/common/optional/caddy.nix"

    ./audiobookshelf.nix
    ./homepage.nix
    ./jellyfin.nix
    ./lubelogger.nix
  ];

  users.groups.media = {
    gid = 6969;
    members = builtins.filter (user: builtins.hasAttr user config.users.users) [
      "audiobookshelf"
      "hotio"
      "jellyfin"
    ];
  };
}
