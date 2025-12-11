{
  imports = [
    ./hardware-configuration.nix
    ./dual-monitors.nix

    ../common/global
    ../common/users/addison
    ../common/users/audrey
  ]
  ++ map (moduleName: ../common/optional/${moduleName}.nix) [
    "docker"
    "kde"
    "mmt"
    "nix-ld"
    "nix-ssh-serve"
    "printing"
    "quickemu"
    "retroarch"
    "signal"
    "snapper"
    "steam"
    "virt-manager"
    "waydroid"
    "wine"
  ];

  services.displayManager.hiddenUsers = [ "nixremote" ];

  networking = {
    hostName = "greenbeen";
    networkmanager.enable = true;
  };

  # Use XBOOTLDR partition to prevent filling the tiny MSFT EFI partition
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  system.stateVersion = "24.05";
}
