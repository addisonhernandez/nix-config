{ inputs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison
    ../common/users/audrey
  ]
  ++ inputs.self.lib.optionalModules [
    "fwupd"
    "heroic"
    "kde"
    "nix-ld"
    "plymouth"
    "printing"
    "retroarch"
    "signal"
    "snapper"
    "steam"
  ];

  networking = {
    hostName = "hedgehog";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "24.05";
}
