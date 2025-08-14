{ inputs }:
{
  # For every flake input, aliases `pkgs.fromInput.${inputName}` to
  # `inputs.${inputName}.legacyPackages.${pkgs.system}` or
  # `inputs.${inputName}.packages.${pkgs.system}`
  inputPkgs =
    _: prev:
    let
      inherit (prev) lib;
      inputHasPkgs = _: input: input ? legacyPackages || input ? packages;
      inputsWithPkgs = lib.filterAttrs inputHasPkgs inputs;
      pkgsFromInput =
        _: input: input.legacyPackages.${prev.system} or input.packages.${prev.system};
    in
    {
      fromInput = lib.mapAttrs pkgsFromInput inputsWithPkgs;
    };

  # Alias `pkgs.stable` to `inputs.nixpkgs-stable.legacyPackages.${pkgs.system}`
  stablePkgs = _: prev: {
    # stable = inputs.nixpkgs-stable.legacyPackages.${prev.system};
    stable = import inputs.nixpkgs-stable {
      inherit (prev) system;
      config.allowUnfree = true;
    };
  };

  # Add custom packages from ../pkgs directly to `pkgs`
  myPkgs = final: _: import "${inputs.self}/pkgs" { pkgs = final; };
}
