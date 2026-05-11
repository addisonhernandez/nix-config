{ inputs, pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      jellyfin
      jellyfin-desktop
      jellyfin-ffmpeg
      jellyfin-web
      ;
  };

  services.caddy.virtualHosts.jellyfin = {
    inherit (inputs.self.lib.tailnet.networkMap.jellyfin)
      extraConfig
      hostName
      serverAliases
      ;
  };
}
