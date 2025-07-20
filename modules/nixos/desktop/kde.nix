{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myNixOS.desktop.kde = {
    enable = lib.mkEnableOption "KDE desktop environment";
  };

  config = lib.mkIf config.myNixOS.desktop.kde.enable {
    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.autoNumlock = true;

    environment = {
      plasma6.excludePackages = with pkgs.kdePackages; [
        elisa # music player
        konsole # terminal
        plasma-browser-integration
      ];

      systemPackages = with pkgs; [
        kdePackages.sddm-kcm
        wl-clipboard
      ];

      sessionVariables = {
        NIXOS_OZONE_WL = 1;
      };
    };

    xdg.portal.enable = true;
    xdg.portal.config.common.default = [ "kde" ];

    system.nixos.tags = [ "kde" ];
  };
}
