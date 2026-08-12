# Hardware:
# Mobo  MSI MS-7751
# CPU   i5-3570K
# GPU   NVIDIA GTX 660 Ti
# Disks
# ├─ 256 GB SSD - nixos
# ├─   2 TB HDD - aux
# └─  24 TB HDD - hdd24tb
{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

    ./nvidia-legacy-470.nix
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
      fsType = "ext4";
      options = [
        "defaults"
        "noatime"
      ];
    };

    "/boot" = {
      label = "boot";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    # Interal HDDs
    "/home" = {
      label = "aux";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "autodefrag"
      ];
    };

    "/mnt/hdd24tb" = {
      label = "hdd24tb";
      fsType = "ext4";
      options = [
        "rw"
        "lazytime"
        "suid"
        "nodev"
        "exec"
        "auto"
        "nouser"
        "async"
        "commit=60" # default 5. reduces head movement
      ];
    };
  };

  swapDevices = [
    # { # swapfile
    #   device = "/var/lib/swapfile"; size = 16 * 1024; # 16 GiB
    # }
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
