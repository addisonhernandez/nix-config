{ inputs, lib, ... }:
let
  pkgsFor = lib.genAttrs (import inputs.systems) (
    system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    }
  );

  forEachSystem =
    f: lib.genAttrs (import inputs.systems) (system: f pkgsFor.${system});
in
{
  flake.lib = { inherit forEachSystem pkgsFor; };
}
