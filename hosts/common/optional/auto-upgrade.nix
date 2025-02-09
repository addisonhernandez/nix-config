let
  defaultStr = default: maybeStr: if maybeStr != "" then maybeStr else default;
  flake = defaultStr "git+https://codeberg.org/addison/nix-config" (builtins.getEnv "FLAKE");
in
{
  system.autoUpgrade = {
    enable = true;

    inherit flake;
    allowReboot = true;
    dates = "daily";
    operation = "boot";
    persistent = true;
    rebootWindow.lower = "01:00";
    rebootWindow.upper = "03:00";
  };
}
