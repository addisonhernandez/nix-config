{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.inputs.agenix.default ];
}
