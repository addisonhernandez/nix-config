{
  inputs,
  lib,
  modulesPath,
  ...
}: let
  inherit (inputs) hardware systems;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    # Hardware: (github.com/NixOS/nixos-hardware)
    # Platform  Beelink SER7
    # CPU       Ryzen 7 7840HS
    # iGPU      Radeon 780M
    hardware.nixosModules.common-cpu-amd
    hardware.nixosModules.common-cpu-amd-pstate
    hardware.nixosModules.common-cpu-amd-raphael-igpu
    hardware.nixosModules.common-cpu-amd-zenpower
    # hardware.nixosModules.common-gpu-amd
    hardware.nixosModules.common-pc
    hardware.nixosModules.common-pc-ssd

    ../common/optional/btrfs.nix
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems = {
    "/" = {
      label = "nixos";
      fsType = "btrfs";
      options = ["subvol=@" "compress=zstd"];
    };

    "/home" = {
      label = "nixos";
      fsType = "btrfs";
      options = ["subvol=@home" "compress=zstd"];
    };

    "/nix" = {
      label = "nixos";
      fsType = "btrfs";
      options = ["subvol=@nix" "compress=zstd" "noatime"];
    };

    "/var/log" = {
      label = "nixos";
      fsType = "btrfs";
      options = ["subvol=@log" "compress=zstd"];
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
