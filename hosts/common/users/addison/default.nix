{ config, lib, ... }:
{
  imports = [
    ./home-manager.nix
    ./secrets.nix
  ];

  users.users.addison = {
    # When isNormalUser = true:
    # group           ~> users
    # createHome      ~> true
    # useDefaultShell ~> true
    # isSystemUser    ~> false
    isNormalUser = true;
    description = "Addison";
    extraGroups = builtins.filter (group: config.users.groups ? ${group}) [
      "audiobookshelf"
      "caddy"
      "docker"
      "flatpak"
      "gamemode"
      "git"
      "immich"
      "jellyfin"
      "kvm"
      "libvirtd"
      "lxd"
      "media"
      "networkmanager"
      "openrazer"
      "podman"
      "samba"
      "wheel"
    ];
    uid = 1000;
  };

  environment.sessionVariables = lib.mkIf config.programs.fish.enable {
    SHELL = lib.getExe config.programs.fish.package;
  };
}
