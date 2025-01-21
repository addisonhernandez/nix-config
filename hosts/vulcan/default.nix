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
      "docker"
      "flatpak"
      "kde"
      "nix-ld"
      "pipewire"
      "printing"
      "signal"
      "snapper"
      "systemd-boot"
      "udisks"
      "xserver"
    ];

  networking = {
    hostName = "vulcan";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
