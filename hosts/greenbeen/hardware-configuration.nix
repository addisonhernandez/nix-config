# Hardware: (github.com/NixOS/nixos-hardware)
# Platform  Beelink SER7
# CPU       Ryzen 7 7840HS
# iGPU      Radeon 780M
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-raphael-igpu
    common-cpu-amd-zenpower
    common-pc
    common-pc-ssd

    ../common/optional/bluetooth.nix
    ../common/optional/btrfs.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "sd_mod"
      "thunderbolt"
      "usbhid"
      "usb_storage"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-amd" ];
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
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    "/efi" = {
      device = "/dev/disk/by-label/SYSTEM";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    "downloads" = {
      label = "aux";
      fsType = "btrfs";
      depends = [ "/home" ];
      mountPoint = "/home/addison/Downloads";
      options = [
        "subvol=@downloads"
        "compress=zstd:15"
      ];
    };

    "games" = {
      label = "aux";
      fsType = "btrfs";
      depends = [ "/home" ];
      mountPoint = "/home/addison/Games";
      options = [
        "subvol=@games"
        "compress=zstd:15"
      ];
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024; # 8 GiB
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
