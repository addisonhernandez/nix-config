{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Hardware: (github.com/NixOS/nixos-hardware/tree/master/dell/xps/15-9560)
    # Platform  Dell XPS 15 9560
    # CPU       Core i7-7700HQ
    # dGPU      NVIDIA GeForce GTX 1050 Mobile
    # iGPU      Intel HD Graphics 630
    # inputs.nixos-hardware.nixosModules.dell-xps-15-9560 # nvidia prime dGPU/iGPU
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560-intel # iGPU only

    ../common/optional/bluetooth.nix
    ../common/optional/btrfs.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "rtsx_pci_sdmmc"
      "sd_mod"
      "usbhid"
      "usb_storage"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  fileSystems = {
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

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [ ];

  # Library to set fan modes and other BIOS settings
  environment.systemPackages = [ pkgs.libsmbios ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
