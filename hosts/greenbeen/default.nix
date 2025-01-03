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
    hostName = "greenbeen";
    networkmanager.enable = true;
  };

  # Use XBOOTLDR partition to prevent filling the tiny MSFT EFI partition
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  system.stateVersion = "24.05";
}
