{pkgs, ...}: {
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

    jellyfin-media-player
  ];
}
