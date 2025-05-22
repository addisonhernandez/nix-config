{
  imports = [ ./lightdm.nix ];

  services.xserver.desktopManager.cinnamon.enable = true;
}
