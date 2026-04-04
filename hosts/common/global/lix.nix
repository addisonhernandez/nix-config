{ pkgs, ... }:
{
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      experimental-features = [
        # Nix uses "pipe-operators" (plural)
        "pipe-operator"
      ];
    };
  };
}
