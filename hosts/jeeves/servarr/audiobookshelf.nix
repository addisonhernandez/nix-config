{ pkgs, ... }:
{
  services.audiobookshelf = {
    enable = true;
    host = "0.0.0.0";
    port = 8008;
  };
  environment.systemPackages = [ pkgs.audiobook-organizer ];

  services.caddy.virtualHosts.audiobookshelf = {
    extraConfig =
      # Caddyfile
      ''
        bind tailscale/audiobookshelf tailscale/audiobooks
        reverse_proxy :8008
      '';
    hostName = "audiobookshelf.beefalo-spica.ts.net";
    serverAliases = [ "audiobooks.beefalo-spica.ts.net" ];
  };
}
