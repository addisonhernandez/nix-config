{...}: {
  imports = [
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

  system.stateVersion = "24.05";
}
