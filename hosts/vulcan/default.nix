{
  imports =
    [
      ./hardware-configuration.nix

      ../common/global
      ../common/users/addison
    ]
    ++ map (moduleName: ../common/optional/${moduleName}.nix) [
      "docker"
      "kde"
      "nix-ld"
      "printing"
      "signal"
      "snapper"
    ];

  networking = {
    hostName = "vulcan";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
