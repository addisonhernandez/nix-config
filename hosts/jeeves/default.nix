{
  imports = [
    # TODO: tweaks for beelink | Alder Lake (12 gen) | N100 chipset
    ./hardware-configuration.nix
    ./intel-graphics-drivers.nix

    ./services

    ../common/global
    ../common/users/addison
    ../common/users/audrey

    ../common/optional/docker.nix
    ../common/optional/flatpak.nix
    ../common/optional/i2p.nix
    ../common/optional/kde.nix
    ../common/optional/pipewire.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/udisks.nix
    ../common/optional/xserver.nix
  ];

  networking = {
    hostName = "jeeves";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
