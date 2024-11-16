{...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison
    ../common/users/audrey

    ../common/optional/docker.nix
    ../common/optional/flatpak.nix
    ../common/optional/kde.nix
    ../common/optional/nix-ld.nix
    ../common/optional/pipewire.nix
    ../common/optional/printing.nix
    ../common/optional/retroarch.nix
    ../common/optional/steam.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/udisks.nix
    ../common/optional/xserver.nix
  ];

  networking = {
    hostName = "hedgehog";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
