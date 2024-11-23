{
  inputs,
  lib,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      flake-registry = ""; # disable global flake registry
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (k: v: "${k}=${v.outPath}") flakeInputs;
  };
}
