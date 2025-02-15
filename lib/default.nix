{ inputs, outputs, ... }:
let
  inherit (inputs) nixpkgs home-manager systems;

  configRoot = ../.;

  lib = nixpkgs.lib // home-manager.lib;

  pkgsFor = lib.genAttrs (import systems) (
    system:
    import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    }
  );
  forEachSystem = f: lib.genAttrs (import systems) (sys: f pkgsFor.${sys});
  mkHostConfig =
    host:
    lib.nixosSystem {
      modules = [ ../hosts/${host} ];
      specialArgs = { inherit inputs outputs configRoot; };
    };
  mkHomeConfig =
    { user, host }:
    {
      "${user}@${host}" = lib.homeManagerConfiguration {
        modules = [
          ../home/${user}/${host}.nix
          ../home/${user}/nixpkgs.nix
        ];
        pkgs = pkgsFor.x86_64-linux; # FIXME: make this architecture agnostic
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
in
lib // { inherit forEachSystem mkHostConfig mkHomeConfig; }
