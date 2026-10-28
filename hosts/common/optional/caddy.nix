{
  config,
  inputs,
  pkgs,
  ...
}:
{
  services.caddy = {
    enable = true;

    # Contains the TS_AUTHKEY environment variable definition
    environmentFile = config.age.secrets.caddyEphemeralAuthkey.path;

    globalConfig =
      # Caddyfile
      ''
        tailscale {
          ephemeral true
          auth_key {$TS_AUTHKEY}
        }
      '';

    package =
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.caddy-with-plugins;
  };

  age.secrets.caddyEphemeralAuthkey = {
    file = "${inputs.secrets}/services/caddy/ephemeral.age";
    owner = config.users.users.caddy.name;
    group = config.users.groups.caddy.name;
  };

  services.tailscale.permitCertUid = toString config.users.users.caddy.uid;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
