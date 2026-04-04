# This file should be included when using hm standalone
{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  inherit (inputs.self.lib) flakeInputs;
in
{
  nix = {
    package = lib.mkDefault pkgs.lixPackageSets.latest.lix;
    settings = {
      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "flakes"
        "nix-command"
        "pipe-operator"
      ];
      flake-registry = ""; # Disable global flake registry
    };
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (k: v: "${k}=flake:${v.outPath}") flakeInputs;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
