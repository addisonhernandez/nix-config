{
  imports =
    let
      optionalImports = map (name: ../common/optional/${name}.nix);
    in
    [
      ./hardware-configuration.nix

      ../common/global
      ../common/users/addison
    ]
    ++ optionalImports [
      # "auto-upgrade"
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
