{ pkgs, ... }:
{
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  environment.systemPackages = [ pkgs.waydroid-helper ];

  # Enable mounting host directories in android containers
  # systemd.packages = [ pkgs.waydroid-helper ];
  # systemd.services.waydroid-mount.wantedBy = [ "multi-user.target" ];
}
