{
  inputs,
  lib,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nix = {
    settings = let
      # jeevesCache = {
      #   substituter = "nixcache.addisonhernandez.com";
      #   publicKey = "";
      # };
      nixCommunityCache = {
        substituter = "https://nix-community.cachix.org";
        publicKey = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
      };
    in {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      flake-registry = ""; # disable global flake registry

      extra-substituters = [nixCommunityCache.substituter];
      extra-trusted-public-keys = [nixCommunityCache.publicKey];

      # TODO: set up a local binary cache on jeeves
      # substituters = lib.mkBefore [jeevesCache.substituter];
      # trusted-public-keys = lib.mkBefore [jeevesCache.publicKey];

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
