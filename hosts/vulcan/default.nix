{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison

    ../common/optional/docker.nix
    ../common/optional/flatpak.nix
    ../common/optional/kde.nix
    ../common/optional/nix-ld.nix
    ../common/optional/pipewire.nix
    ../common/optional/printing.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/udisks.nix
    ../common/optional/xserver.nix
  ];

  networking = {
    hostName = "vulcan";
    networkmanager.enable = true;
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
