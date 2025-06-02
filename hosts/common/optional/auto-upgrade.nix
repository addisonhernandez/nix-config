{ lib, ... }:
{
  system.autoUpgrade = {
    enable = true;

    flake = lib.defaultStr "git+https://codeberg.org/addison/nix-config" (builtins.getEnv "NH_FLAKE");
    allowReboot = true;
    dates = "daily";
    operation = "boot";
    persistent = true;
    rebootWindow.lower = "01:00";
    rebootWindow.upper = "03:00";
  };
}
