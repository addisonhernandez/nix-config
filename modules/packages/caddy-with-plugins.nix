{
  perSystem =
    { pkgs, ... }:
    {
      packages.caddy-with-plugins = pkgs.caddy.withPlugins {
        plugins = [
          # See: https://wiki.nixos.org/wiki/Caddy#Plug-ins for plugin version tag
          # https://github.com/tailscale/caddy-tailscale/commit/de41b249af4fd2083612c3b2303197e92787d1c5
          "github.com/tailscale/caddy-tailscale@v0.0.0-20260826180304-de41b249af4f"
        ];
        hash = [ "sha256-I9A+/rwj97qu2yAP3rm+4+QBJjOKzngMM14nWZ3r6Q4=" ];
      };
    };
}
