{ pkgs, ... }:
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

    jellyfin-media-player
  ];

  services.caddy.virtualHosts.jellyfin = {
    extraConfig =
      # Caddyfile
      ''
        bind tailscale/jellyfin tailscale/media
        reverse_proxy :8096
      '';
    hostName = "jellyfin.beefalo-spica.ts.net";
    serverAliases = [ "media.beefalo-spica.ts.net" ];
  };
}
