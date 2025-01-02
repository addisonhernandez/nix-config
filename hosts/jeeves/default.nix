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
      "docker"
      "flatpak"
      "kde"
      "pipewire"
      "systemd-boot"
      "udisks"
      "xserver"
    ];

  networking = {
    hostName = "jeeves";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
