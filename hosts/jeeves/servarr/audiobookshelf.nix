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
  services.audiobookshelf = {
    enable = true;
    host = "0.0.0.0";
    port = 8008;
  };
  environment.systemPackages = [ pkgs.audiobook-organizer ];

  services.caddy.virtualHosts.audiobookshelf = mkTailnetNode "audiobookshelf";
}
