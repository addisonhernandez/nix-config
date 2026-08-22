{ inputs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    # ./interactive-login.nix
    ./plasma-bigscreen.nix
    ./sddm-4k-scaling.nix

    ./servarr

    ../common/global
    ../common/users/addison
    ../common/users/audrey
  ]
  ++ inputs.self.lib.optionalModules [
    "docker"
    "kde"
    "nix-ld"
    "nix-ssh-serve"
    "plymouth"
    "steam"
  ];

  networking = {
    hostName = "jeeves";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.displayManager.autoLogin.user = "addison";

  system.stateVersion = "24.05";
}
