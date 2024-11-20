{
  pkgs,
  config,
  outputs,
  ...
}: let
  inherit (outputs) configRoot;
  hostName = config.networking.hostName;
  ifTheyExist = builtins.filter (group: builtins.hasAttr group config.users.groups);
in {
  users = {
    # mutableUsers = false;
    users.addison = {
      isNormalUser = true;
      description = "Addison";
      shell = pkgs.fish;
      extraGroups = ifTheyExist [
        "docker"
        "git"
        "jellyfin"
        "libvirtd"
        "lxd"
        "media"
        "networkmanager"
        "podman"
        "wheel"
      ];

      packages = [pkgs.home-manager];
    };
  };

  home-manager.users.addison = import "${configRoot}/home/addison/${hostName}.nix";
}
