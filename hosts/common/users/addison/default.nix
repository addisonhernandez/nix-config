{
  pkgs,
  config,
  configRoot,
  ...
}:
let
  inherit (config.networking) hostName;
  ifTheyExist = builtins.filter (group: builtins.hasAttr group config.users.groups);
in
{
  users.users.addison = {
    isNormalUser = true;
    description = "Addison";
    shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "caddy"
      "docker"
      "flatpak"
      "gamemode"
      "git"
      "jellyfin"
      "libvirtd"
      "lxd"
      "media"
      "networkmanager"
      "podman"
      "wheel"
    ];

    packages = [ pkgs.home-manager ];
  };

  home-manager.users.addison = import "${configRoot}/home/addison/${hostName}.nix";
}
