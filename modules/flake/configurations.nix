# [fixme] relocate to @/modules/
{ self, lib, ... }:
{
  flake =
    let
      hostnames = [
        "greenbeen" # Mini Desktop (Beelink SER7)
        "hedgehog" # Laptop (Dell XPS 9560)
        # "iso" # Custom installer image
        "jeeves" # Media Server (Beelink Mini S12 Pro)
        "vulcan" # Desktop
      ];
      usernames = [
        "addison"
        "audrey"
      ];
      userHostPairs = lib.cartesianProduct {
        user = usernames;
        host = hostnames;
      };

      forEachHost = lib.genAttrs (hostnames ++ [ "iso" ]);
      forEachHome = f: lib.mergeAttrsList (map f userHostPairs);
    in
    {
      nixosConfigurations = forEachHost self.lib.mkHostConfig;
      homeConfigurations = forEachHome self.lib.mkHomeConfig;
    };
}
