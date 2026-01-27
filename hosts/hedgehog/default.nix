{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison
    ../common/users/audrey
  ]
  ++ map (moduleName: ../common/optional/${moduleName}.nix) [
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

  networking.hostName = "hedgehog";
  networking.networkmanager.enable = true;

  system.stateVersion = "24.05";
}
