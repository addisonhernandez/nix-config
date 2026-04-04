{ inputs, pkgs, ... }:

{
  # services.jellyfin = {
  #   enable = true;
  #   user = "addison";

  #   # configDir = "";
  #   # dataDir = "";
  #   # cacheDir = "";
  #   # logDir = "";
  # };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      jellyfin
      jellyfin-desktop
      jellyfin-ffmpeg
      jellyfin-web
      ;
  };

  services.caddy.virtualHosts.jellyfin =
    let
      inherit (inputs.self.lib.tailnet.networkMap) jellyfin;
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
