{ inputs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison
  ]
  ++ inputs.self.lib.optionalModules [
    "caddy"
    "immich"
    "nix-ld"
    "snapper"
    "xfce"
  ];

  networking = {
    hostName = "vulcan";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "26.05";
}
