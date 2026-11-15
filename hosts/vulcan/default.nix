{ inputs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nfs-server.nix
    ./samba-shares.nix

    ../common/global
    ../common/users/addison
  ]
  ++ inputs.self.lib.optionalModules [
    "caddy"
    "immich"
    "nix-ld"
    "samba-server"
    "snapper"
    "xfce"
  ];

  networking = {
    hostName = "vulcan";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "26.11";
}
