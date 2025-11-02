# [fixme] relocate to @/modules/nixos
{ self, ... }:
{
  flake.nixosModules = import (self + "/modules/nixos");
}
