{ config, ... }:
{
  imports = [
    ./home-manager.nix
    ./secrets.nix
  ];

  users.users.addison = {
    isNormalUser = true;
    description = "Addison";
    shell =
      if config.programs.fish.enable then
        config.programs.fish.package
      else
        config.users.defaultUserShell;
    extraGroups = builtins.filter (g: builtins.hasAttr g config.users.groups) [
      "audiobookshelf"
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
  };
}
