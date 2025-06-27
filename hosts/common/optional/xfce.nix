{ pkgs, ... }:
{
  services = {
    xserver.enable = true;
    xserver.desktopManager.xfce.enable = true;
    displayManager.defaultSession = "xfce";
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-xapp ];
  # xdg.portal.config.common.default = [ "" ];
}
