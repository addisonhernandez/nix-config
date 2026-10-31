{ pkgs, ... }:
{
  imports = [ ./plasma-login.nix ];

  services.desktopManager.plasma6.enable = true;

  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa # music player
      konsole # terminal
      plasma-browser-integration
    ];

    systemPackages = with pkgs; [
      kdePackages.filelight # disk usage visualizer
      wl-clipboard
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };

  programs.kdeconnect.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = [ "kde" ];
  };
}
