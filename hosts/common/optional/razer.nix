{ outputs, pkgs, ... }:
{
  hardware.openrazer = {
    enable = true;
    batteryNotifier.enable = false;
    users = outputs.usernames;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      polychromatic
      razer-cli
      razergenie
      ;
  };
}
