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
      "docker"
      "flatpak"
      "fwupd"
      "kde"
      "nix-ld"
      "pipewire"
      "printing"
      "retroarch"
      "snapper"
      "steam"
      "systemd-boot"
      "udisks"
      "virt-manager"
      "xserver"
    ];

  networking = {
    hostName = "hedgehog";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
