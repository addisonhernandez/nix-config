# [todo] Remove this file in favor of `import-tree ./modules` at the top-level
{
  # Enable option and config attribute introspection in `nix repl`.
  debug = true;

  imports = [
    ./dendritic.nix
    ./devShells.nix
    ./formatter.nix
    ./systems.nix
  ];
}
