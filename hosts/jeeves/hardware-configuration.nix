{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems = {
    "/" = {
      label = "nixos";
      fsType = "btrfs";
      options = ["subvol=@" "compress=zstd"];
    };

    # "/home" = {
    #   label = "nixos";
    #   fsType = "btrfs";
    #   options = ["subvol=@home" "compress=zstd"];
    # };

    "/homelab" = {
      label = "nixos";
      fsType = "btrfs";
      options = ["subvol=@homelab" "compress=zstd"];
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
      options = ["fmask=0022" "dmask=0022"];
    };

    "/mnt/Passport" = {
      device = "/dev/disk/by-label/Passport4TB";
      fsType = "ntfs3";
      options = [
        "nosuid"
        "nodev"
        "relatime"
        "users"
        "uid=1000"
        "gid=100"
        "nofail"
      ];
    };

    "/homelab/data/media" = {
      depends = ["/mnt/Passport"];
      device = "/mnt/Passport/media";
      options = ["bind"];
    };

    "/homelab/data/torrents" = {
      depends = ["/mnt/Passport"];
      device = "/mnt/Passport/torrents";
      options = ["bind"];
    };
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
