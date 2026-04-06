{ pkgs, ... }:
{
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      experimental-features = [
        # Allow "v${version}" instead of "v${toString version}"
        "coerce-integers"
        # Nix uses "pipe-operators" (plural)
        "pipe-operator"
      ];
    };
  };
}
