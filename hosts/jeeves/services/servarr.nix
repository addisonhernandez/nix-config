{
  imports = [
    ./caddy.nix
    ./jellyfin.nix
  ];

  users.groups.media = {
    gid = 6969;
    members = [
      "hotio"
      "jellyfin"
    ];
  };
}
