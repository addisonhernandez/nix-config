{
  imports =
    let
      optionalImports = map (name: ../common/optional/${name}.nix);
    in
    [
      ./hardware-configuration.nix

      ../common/global
      ../common/users/addison
      ../common/users/audrey
    ]
    ++ optionalImports [
      "auto-upgrade"
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
