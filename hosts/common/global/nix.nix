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
        "repl-flake"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}
