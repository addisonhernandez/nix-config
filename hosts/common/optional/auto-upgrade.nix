{
  system.autoUpgrade = {
    enable = true;

    allowReboot = true;
    dates = "daily";
    flake = "git+https://codeberg.org/addison/nix-config";
    operation = "boot";
    persistent = true;
    rebootWindow.lower = "01:00";
    rebootWindow.upper = "03:00";
  };
}
