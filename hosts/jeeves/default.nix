{
  imports =
    let
      optionalImports = map (name: ../common/optional/${name}.nix);
    in
    [
      ./hardware-configuration.nix
      ./interactive-login.nix
      ./sddm-4k-scaling.nix

      ./servarr

      ../common/global
      ../common/users/addison
      ../common/users/audrey
    ]
    ++ optionalImports [
      "kde"
      "nix-ld"
      "nix-ssh-serve"
      "steam"
    ];

  networking = {
    hostName = "jeeves";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
