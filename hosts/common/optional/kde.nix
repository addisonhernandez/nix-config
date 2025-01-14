{ pkgs, ... }:
{
  imports = [ ./sddm.nix ];

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs; [
    elisa # music player
    konsole # terminal
    plasma-browser-integration
  ];

  xdg.portal = {
    enable = true;
    config.common.default = [ "kde" ];
  };

  environment.systemPackages = [ pkgs.wl-clipboard ];
}
