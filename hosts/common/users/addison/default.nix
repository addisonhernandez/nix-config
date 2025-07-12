{
  config,
  inputs,
  pkgs,
  ...
}:
{
  users.users.addison = {
    isNormalUser = true;
    description = "Addison";
    shell = pkgs.fish;
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

    packages = [ pkgs.home-manager ];
  };

  home-manager.users = {
    addison = import "${inputs.self}/home/addison/${config.networking.hostName}.nix";
  };
}
