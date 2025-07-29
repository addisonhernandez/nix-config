{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison
  ]
  ++ map (moduleName: ../common/optional/${moduleName}.nix) [
    "nix-ld"
    "snapper"
    "xfce"
  ];

  networking.hostName = "vulcan";
  networking.networkmanager.enable = true;

  system.stateVersion = "24.05";
}
