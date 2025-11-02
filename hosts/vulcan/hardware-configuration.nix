{
  config,
  inputs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    # Hardware:
    # Mobo  MSI MS-7751
    # CPU   i5-3570K
    # GPU   NVIDIA GTX 660 Ti
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

    ./nvidia-legacy-470.nix

    ../common/optional/btrfs.nix
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "ehci_pci"
    "sd_mod"
    "sr_mod"
    "usbhid"
    "usb_storage"
    "xhci_pci"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems = {
    # Root SSD
    "/" = {
      label = "nixos";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "compress=zstd"
      ];
    };

    "/home" = {
      label = "nixos";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
      ];
    };

    "/nix" = {
      label = "nixos";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
      ];
    };

    "/var/log" = {
      label = "nixos";
      fsType = "btrfs";
      options = [
        "subvol=@log"
        "compress=zstd"
      ];
    };

    # Boot EFI
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    # Interal HDD
    "backup" = {
      label = "aux";
      fsType = "btrfs";
      mountPoint = "/home/addison/Documents/backup";
      options = [
        "subvol=@backup"
        "autodefrag"
        "noatime"
        "compress=zstd:15"
      ];
    };

    "games" = {
      label = "aux";
      fsType = "btrfs";
      mountPoint = "/home/addison/Games";
      options = [
        "subvol=@games"
        "autodefrag"
        "compress=zstd:15"
      ];
    };

    "temp" = {
      label = "aux";
      fsType = "btrfs";
      mountPoint = "/home/addison/Downloads/.temp";
      options = [
        "subvol=@temp"
        "autodefrag"
        "noatime"
        "compress=zstd:15"
      ];
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
