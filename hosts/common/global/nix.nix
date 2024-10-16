{
  inputs,
  lib,
  pkgs,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nix = {
    # package = pkgs.nixVersions.latest;

    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}
