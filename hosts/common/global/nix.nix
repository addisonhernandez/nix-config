{ inputs, lib, ... }:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      download-buffer-size = 1024 * 1024 * 1024;
      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      flake-registry = ""; # disable global flake registry
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
    };

    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (k: v: "${k}=${v.outPath}") flakeInputs;
  };
}
