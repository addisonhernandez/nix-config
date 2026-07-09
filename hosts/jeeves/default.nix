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
  ++ map (moduleName: ../common/optional/${moduleName}.nix) [
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
  };

  services.displayManager.autoLogin.user = "addison";

  system.stateVersion = "24.05";
}
