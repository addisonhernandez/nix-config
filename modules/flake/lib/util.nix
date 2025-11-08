{ inputs, lib, ... }:
{
  flake.lib.pkgsFor = lib.genAttrs (import inputs.systems) (
    system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    }
  );
}
