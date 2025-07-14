{
  config,
  inputs,
  pkgs,
  ...
}:
{
  services.caddy = {
    enable = true;

    environmentFile = config.age.secrets.caddyNixosAuthkey.path;

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
      hash = [ "sha256-K4K3qxN1TQ1Ia3yVLNfIOESXzC/d6HhzgWpC1qkT22k=" ];
    };
  };

  age.secrets.caddyNixosAuthkey.file = "${inputs.secrets}/services/caddy/nixos-authkey.age";

  services.tailscale.permitCertUid = toString config.users.users.caddy.uid;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
