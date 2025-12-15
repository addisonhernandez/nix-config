{ pkgs, ... }:
{
  imports = [ ./sddm.nix ];

  services.desktopManager.plasma6.enable = true;

  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa # music player
      konsole # terminal
      plasma-browser-integration
    ];

    systemPackages = with pkgs; [
      wl-clipboard
      # sddm system settings configuration plugin
      kdePackages.sddm-kcm
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = [ "kde" ];
  };
}
