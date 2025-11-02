let
  defaultFlakeRef = "git+https://codeberg.org/addison/nix-config";
  flakeOrDefault = maybeStr: if maybeStr != "" then maybeStr else defaultFlakeRef;
in
{
  system.autoUpgrade = {
    enable = true;

    flake = builtins.getEnv "NH_FLAKE" |> flakeOrDefault;
    allowReboot = true;
    dates = "daily";
    operation = "boot";
    persistent = true;
    rebootWindow.lower = "01:00";
    rebootWindow.upper = "03:00";
  };
}
