{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    # [todo] simplify using flake-parts self' parameter
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.mmt
  ];
}
