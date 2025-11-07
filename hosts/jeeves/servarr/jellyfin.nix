{ config, pkgs, ... }:

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

  services.caddy.virtualHosts.jellyfin =
    let
      inherit (config.myUtils.tailnet.networkMap) jellyfin;
    in
    {
      extraConfig =
        # Caddyfile
        ''
          bind ${jellyfin.bindHosts}
          reverse_proxy :${toString jellyfin.proxiedPort}
        '';
      hostName = builtins.head jellyfin.FQDNs;
      serverAliases = builtins.tail jellyfin.FQDNs;
    };
}
