{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.lib = {
    # From the set of the inputs of this flake config, remove any attributes
    # which are not flakes, and remove the self-reference flake.
    flakeInputs = lib.filterAttrs (
      name: input: name != "self" && lib.isType "flake" input
    ) inputs;

    # Fn that maps optional host module names to strings representing relative
    # paths to that module.
    # Type: [String] -> [String]
    optionalModules = map (
      moduleName: "${self}/hosts/common/optional/${moduleName}.nix"
    );
  };
}
