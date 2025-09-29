{ inputs, lib, ... }:
{
  imports = [
    inputs.hardware.nixosModules.microsoft-surface-common

    ../common/optional/bluetooth.nix
    ../common/optional/btrfs.nix
  ];

  boot.initrd.availableKernelModules = [ ];
  boot.kernelModules = [ ];

  fileSystems =
    let
      label = "nixos";
      fsType = "btrfs";
    in
    {
      "/" = {
        inherit fsType label;
        options = [
          "subvol=@"
          "compress=zstd:15"
        ];
      };
      "/home" = {
        inherit fsType label;
        options = [
          "subvol=@"
          "compress=zstd:15"
        ];
      };
      "/nix" = {
        inherit fsType label;
        options = [
          "subvol=@"
          "compress=zstd:15"
          "noatime"
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
    };

  swapDevices = [ ];

  hardware.enableAllFirmware = true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = "x86_64-linux";
}
