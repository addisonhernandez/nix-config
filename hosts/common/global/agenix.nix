{ inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [ inputs.agenix.nixosModules.default ];
  # [todo] migrate to perSystem
  environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
}
