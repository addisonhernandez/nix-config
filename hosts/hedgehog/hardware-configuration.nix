# Hardware: (github.com/NixOS/nixos-hardware/tree/master/dell/xps/15-9560)
# Platform  Dell XPS 15 9560
# CPU       Core i7-7700HQ (Kaby Lake)
# dGPU      NVIDIA GeForce GTX 1050 Mobile (Pascal)
# iGPU      Intel HD Graphics 630
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    "${inputs.nixos-hardware}/common/cpu/intel/kaby-lake"
    "${inputs.nixos-hardware}/common/pc/laptop"
    "${inputs.nixos-hardware}/dell/xps/15-9560/xps-common.nix"

    ./gpu-specialisations.nix

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

  nfs-client.mounts.backup.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GiB
    }
  ];

  # Library to set fan modes and other BIOS settings
  environment.systemPackages = [ pkgs.libsmbios ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
