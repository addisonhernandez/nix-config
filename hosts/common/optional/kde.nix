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

    systemPackages = [ pkgs.wl-clipboard ];

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };

  systemd.services."drkonqi-coredump-pickup".enable = false;

  xdg.portal = {
    enable = true;
    config.common.default = [ "kde" ];
  };
}
