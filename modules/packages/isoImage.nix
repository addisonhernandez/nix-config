{ self, ... }:
let
  inherit (self.nixosConfigurations) iso;
in
{
  flake.packages.${iso.pkgs.stdenv.hostPlatform.system} = {
    inherit (iso.config.system.build) isoImage;
  };
}
