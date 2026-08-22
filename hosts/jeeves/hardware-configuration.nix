# Hardware: (github.com/NixOS/nixos-hardware)
# Platform  Beelink Mini S12
# CPU       Intel N100 (Alder Lake)
# iGPU      Intel UHD Graphics
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./intel-graphics-drivers.nix

    ../common/optional/bluetooth.nix
    ../common/optional/btrfs.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
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

    # "/home" = {
    #   label = "nixos";
    #   fsType = "btrfs";
    #   options = ["subvol=@home" "compress=zstd"];
    # };

    "/homelab" = {
      label = "nixos";
      fsType = "btrfs";
      options = [
        "subvol=@homelab"
        "compress=zstd"
      ];
    };

    # "/nix" = {
    #   label = "nixos";
    #   fsType = "btrfs";
    #   options = ["subvol=@nix" "compress=zstd" "noatime"];
    # };

    # "/var/log" = {
    #   label = "nixos";
    #   fsType = "btrfs";
    #   options = ["subvol=@log" "compress=zstd"];
    # };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/homelab/data" = {
      device = "/dev/disk/by-label/Passport4TB";
      fsType = "ntfs3";
      options = [
        "nosuid"
        "nodev"
        "relatime"
        "users"
        "uid=1000"
        # "gid=100" # users
        "gid=6969" # media
        "nofail"
      ];
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GiB
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
