{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wineWowPackages.unstable
    # wineWowPackages.wayland
    wineWowPackages.fonts
    winetricks
  ];
}
