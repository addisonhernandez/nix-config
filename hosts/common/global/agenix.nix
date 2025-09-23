{ inputs, pkgs, ... }:
{
  imports = [ inputs.agenix.nixosModules.default ];
  environment.systemPackages = [ pkgs.fromInput.agenix.default ];
}
