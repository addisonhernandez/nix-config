{ self, ... }:
let
  inherit (self.nixosConfigurations) iso;
  inherit (iso.pkgs.stdenv.hostPlatform) system;
  inherit (iso.config.system.build) isoImage;
in
{
  flake.packages.${system} = { inherit isoImage; };
}
