{
  imports =
    let
      optionalImports = map (name: ../common/optional/${name}.nix);
    in
    [
      ./hardware-configuration.nix
      ./dual-monitors.nix

      ../common/global
      ../common/users/addison
      ../common/users/audrey
    ]
    ++ optionalImports [
      "kde"
      "nix-ld"
      "nix-ssh-serve"
      "printing"
      "retroarch"
      "signal"
      "snapper"
      "steam"
      "virt-manager"
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
