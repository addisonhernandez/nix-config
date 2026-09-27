{ pkgs, ... }:
let
  inherit (pkgs.kdePackages) plasma-bigscreen;
in
{
  imports = [ ./kde.nix ];

  environment.systemPackages = [ plasma-bigscreen ];

  services.displayManager = {
    defaultSession = "plasma-bigscreen-wayland";
    sessionPackages = [ plasma-bigscreen ];
  };

  xdg.portal.configPackages = [ plasma-bigscreen ];
}
