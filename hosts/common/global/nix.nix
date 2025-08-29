{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  nix = {
    package = pkgs.lixPackageSets.latest.lix;

    settings = {
      auto-optimise-store = lib.mkDefault true;
      # download-buffer-size = 1024 * 1024 * 1024;
      experimental-features = [
        "flakes"
        "nix-command"
        "pipe-operator"
      ];
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      flake-registry = "";
      keep-going = true;
      trusted-users = [ "@wheel" ];
      warn-dirty = false;
    };

    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (k: v: "${k}=${v.outPath}") flakeInputs;
  };
}
