{ inputs, lib, ... }:
{
  flake.lib = {
    # A set of instantiated nixpkgs for each supported system.
    #
    # Ex: `self.lib.pkgsFor.x86_64-linux`
    pkgsFor = lib.genAttrs (import inputs.systems) (
      system:
      import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      }
    );

    # From the set of the inputs of this flake config, remove any attributes
    # which are not flakes, and remove the self-reference flake.
    flakeInputs = lib.filterAttrs (
      name: input: name != "self" && lib.isType "flake" input
    ) inputs;
  };
}
