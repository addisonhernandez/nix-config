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
      auto-optimise-store = true;
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      flake-registry = "";
      http-connections = 50; # default: 25
      keep-going = true;
      trusted-users = [ "@wheel" ];
      use-xdg-base-directories = true;
      warn-dirty = false;

      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "no-url-literals"
        "pipe-operator"
      ];
      auto-allocate-uids = true;
      use-cgroups = true;
    };

    channel.enable = false;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (k: v: "${k}=${v.outPath}") flakeInputs;
  };
}
