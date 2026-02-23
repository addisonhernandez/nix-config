{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.unstable
    # wineWow64Packages.wayland
    wineWow64Packages.fonts
    winetricks
  ];
}
