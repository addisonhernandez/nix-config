{ config, ... }:
{
  nixpkgs.config = {
    nvidia.acceptLicense = true;
    problems.handlers."gtk+".broken = "warn";
  };
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
}
