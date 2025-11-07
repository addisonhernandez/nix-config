# [todo] Relocate pkgs dir
{ inputs, ... }:
let
  pkgNames = builtins.attrNames (builtins.readDir "${inputs.self}/pkgs");
in
{
  perSystem =
    { lib, pkgs, ... }:
    {
      packages = lib.genAttrs pkgNames (
        name: pkgs.callPackage "${inputs.self}/pkgs/${name}" { }
      );
    };
}
