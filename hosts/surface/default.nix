{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison
    ../common/users/audrey
  ]
  ++ map (moduleName: ../common/optional/${moduleName}.nix) [
    "fwupd"
    "nix-ld"
    "printing"
    "retroarch"
    "signal"
    "snapper"
    "steam"
    "xfce"
  ];

  networking.hostName = "surface";
  networking.networkmanager.enable = true;

  system.stateVersion = "25.11";
}
