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
    extraGroups = builtins.filter (g: builtins.hasAttr g config.users.groups) [
      "audiobookshelf"
      "caddy"
      "docker"
      "flatpak"
      "gamemode"
      "git"
      "jellyfin"
      "kvm"
      "libvirtd"
      "lxd"
      "media"
      "networkmanager"
      "podman"
      "wheel"
    ];
    uid = 1000;
  };

  environment.sessionVariables = lib.mkIf config.programs.fish.enable {
    SHELL = lib.getExe config.programs.fish.package;
  };
}
