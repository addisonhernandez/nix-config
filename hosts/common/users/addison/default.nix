{ config, lib, ... }:
{
  imports = [
    ./home-manager.nix
    ./secrets.nix
  ];

  users.users.addison = {
    isNormalUser = true;
    description = "Addison";
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

  environment.sessionVariables = lib.mkIf config.programs.fish.enable {
    SHELL = lib.getExe config.programs.fish.package;
  };
}
