{
  config,
  inputs,
  pkgs,
  ...
}:
{
  services.caddy = {
    enable = true;

    environmentFile = config.age.secrets.caddyEphemeralAuthkey.path;

    globalConfig =
      # Caddyfile
      ''
        tailscale {
          ephemeral true
          auth_key {$TS_AUTHKEY}
        }
      '';

    package = pkgs.caddy.withPlugins {
      plugins = [
        # See: https://wiki.nixos.org/wiki/Caddy#Plug-ins for plugin version tag
        "github.com/tailscale/caddy-tailscale@v0.0.0-20250508175905-642f61fea3cc"
      ];
      hash = [ "sha256-r9EDkhcgwK11dB46AV+Em8ZE6Aa7IDMwibDGkg3e/rc=" ];
    };
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
