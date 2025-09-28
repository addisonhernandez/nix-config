{
  config,
  outputs,
  pkgs,
  ...
}:
let
  mkTailnetNode = outputs.lib.mkTailnetNode config;
in
{
  # services.jellyfin = {
  #   enable = true;
  #   user = "addison";

  #   # configDir = "";
  #   # dataDir = "";
  #   # cacheDir = "";
  #   # logDir = "";
  # };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

    # jellyfin-media-player
  ];

  # [fixme] temp fix while jellyfin-media-player depends on qt5
  nixpkgs.config.permittedInsecurePackages = [
    pkgs.libsForQt5.qt5.qtwebengine.name
  ];

  services.caddy.virtualHosts.jellyfin = mkTailnetNode "jellyfin";
}
