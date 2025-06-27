{ config, ... }:
{
  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  # services.displayManager.defaultSession = "plasmax11";
}
