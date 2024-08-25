{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    ./hardware-configuration.nix

    ./services

    ../common/global
    ../common/users/addison

    ../common/optional/docker.nix
    ../common/optional/flatpak.nix
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

  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

  # configure dual monitors
  # HDMI: primary
  # DP: secondary on the left and rotated with left edge up
  services.xserver.displayManager.setupCommands = ''
    xrandr \
      --output DP-1 --mode 1080x1920 --pos 0x0 --rotate left \
      --output HDMI-0 --primary --mode 1920x1080 --pos 1080x250
  '';

  system.stateVersion = "24.05";
}
