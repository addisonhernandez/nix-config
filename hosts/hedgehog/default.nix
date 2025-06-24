{
  imports =
    [
      ./hardware-configuration.nix

      ../common/global
      ../common/users/addison
      ../common/users/audrey
    ]
    ++ map (moduleName: ../common/optional/${moduleName}.nix) [
      "docker"
      "fwupd"
      "kde"
      "nix-ld"
      "printing"
      "retroarch"
      "signal"
      "snapper"
      "steam"
      "virt-manager"
    ];

  networking = {
    hostName = "hedgehog";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
