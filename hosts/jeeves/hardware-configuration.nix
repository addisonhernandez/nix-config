{ inputs, lib, ... }:
{
  imports =
    with inputs.nixos-hardware.nixosModules;
    [
      # Hardware: (github.com/NixOS/nixos-hardware)
      # Platform  Beelink Mini S12
      # CPU       Intel N100 (Alder Lake)
      # iGPU      Intel UHD Graphics
      common-cpu-intel-cpu-only
      common-pc
      common-pc-ssd
    ]
    ++ [
      ./intel-graphics-drivers.nix

      ../common/optional/bluetooth.nix
      ../common/optional/btrfs.nix
    ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "sd_mod"
    "usbhid"
    "usb_storage"
    "xhci_pci"
  ];
  boot.kernelModules = [ "kvm-intel" ];

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

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
