{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.users) users;
  userNames = builtins.attrNames users;
  userIsNormal = u: lib.getAttrFromPath [ u "isNormalUser" ] users;
in
{
  config = {
    hardware.openrazer = {
      enable = true;

      batteryNotifier.enable = false;
      users = builtins.filter userIsNormal userNames;
    };

    environment.systemPackages = [ pkgs.polychromatic ];
  };
}
