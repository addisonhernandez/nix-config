{
  imports =
    let
      optionalImports = map (name: ../common/optional/${name}.nix);
    in
    [
      ./hardware-configuration.nix

      ./servarr

      ../common/global
      ../common/users/addison
      ../common/users/audrey
    ]
    ++ optionalImports [
      "kde"
      "nix-ssh-serve"
    ];

  networking = {
    hostName = "jeeves";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
