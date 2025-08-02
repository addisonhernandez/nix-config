{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.fromInput.agenix.default ];
}
