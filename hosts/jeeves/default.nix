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
  ];

  networking = {
    hostName = "jeeves";
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
