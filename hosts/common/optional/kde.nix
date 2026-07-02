{ pkgs, ... }:
{
  imports = [ ./plasma-login.nix ];

  services.desktopManager.plasma6.enable = true;

  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa # music player
      konsole # terminal
      plasma-browser-integration
      qrca # QR code scanner
    ];

    systemPackages = with pkgs; [
      kdePackages.filelight # disk usage visualizer
      kdePackages.kdeconnect-kde
      wl-clipboard
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
