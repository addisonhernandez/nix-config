{pkgs, ...}: {
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs; [
    konsole # terminal
    elisa # music player
  ];
  xdg.portal = {
    enable = true;
    config.common.default = ["kde"];
  };
}
