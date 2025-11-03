{ inputs }:
{
  # [todo] Remove? This is redundant with flake-parts `inputs'` parameter.
  # For every flake input, aliases `pkgs.fromInput.${inputName}` to
  # `inputs.${inputName}.legacyPackages.${pkgs.system}` or
  # `inputs.${inputName}.packages.${pkgs.system}`
  inputPkgs =
    _: prev:
    let
      inherit (prev) lib;
      inherit (prev.stdenv.hostPlatform) system;

      inputHasPkgs = _: input: input ? legacyPackages || input ? packages;
      inputsWithPkgs = lib.filterAttrs inputHasPkgs inputs;

      pkgsFromInput =
        _: input: input.legacyPackages.${system} or input.packages.${system};
    in
    {
      fromInput = lib.mapAttrs pkgsFromInput inputsWithPkgs;
    };

  # Alias `pkgs.stable` to `inputs.nixpkgs-stable.legacyPackages.${pkgs.system}`
  stablePkgs = _: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (prev.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };

  # [todo] Remove in favor of `self'.packages.<name>`
  # Add custom packages from ../pkgs directly to `pkgs`
  myPkgs =
    final: prev: # import "${inputs.self}/pkgs" { pkgs = final; };
    let
      pkgNames = builtins.attrNames (builtins.readDir "${inputs.self}/pkgs");
    in
    prev.lib.genAttrs pkgNames (
      name: prev.callPackage "${inputs.self}/pkgs/${name}" { }
    );
}
