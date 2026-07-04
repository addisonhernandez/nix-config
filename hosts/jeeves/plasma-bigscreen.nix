{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.kdePackages.plasma-bigscreen ];
}
