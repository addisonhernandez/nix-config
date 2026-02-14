{ self, ... }:
let
  inherit (self.nixosConfigurations.iso.pkgs.stdenv.hostPlatform) system;
  inherit (self.nixosConfigurations.iso.config.system.build) isoImage;
in
{
  flake.packages.${system} = { inherit isoImage; };
}
