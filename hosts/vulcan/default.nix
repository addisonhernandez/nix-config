{
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime

    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison
  ];

  networking = {
    hostName = "vulcan";
    networkmanager.enable = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };

  system.stateVersion = "24.05";
}
