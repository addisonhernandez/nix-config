{ inputs, ... }:
{
  services = {
    redlib = {
      enable = true;

      address = "0.0.0.0";
      openFirewall = true;
      port = 8069;

      # For available settings:
      # https://github.com/redlib-org/redlib/tree/main?tab=readme-ov-file#configuration
      settings = {
        REDLIB_ROBOTS_DISABLE_INDEXING = true;
        REDLIB_ENABLE_RSS = false;

        REDLIB_DEFAULT_SHOW_NSFW = true;
        REDLIB_DEFUALT_HIDE_AWARDS = true;
      };
    };

    # caddy.virtualHosts = { inherit (inputs.self.lib.tailnet.networkMap) redlib; };
    caddy.virtualHosts.redlib = {
      inherit (inputs.self.lib.tailnet.networkMap.redlib)
        extraConfig
        hostName
        serverAliases
        ;
    };
  };
}
