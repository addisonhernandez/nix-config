{ inputs, pkgs, ... }:
{
  services.audiobookshelf = {
    enable = true;
    host = "0.0.0.0";
    port = 8008;
  };
  environment.systemPackages = [
    # [todo] simplify with flake-parts self' parameter
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.audiobook-organizer
  ];

  services.caddy.virtualHosts.audiobookshelf = {
    inherit (inputs.self.lib.tailnet.networkMap.audiobookshelf)
      extraConfig
      hostName
      serverAliases
      ;
  };
}
