{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  networking.networkmanager.unmanaged = [ "interface-name:docker*" ];
}
