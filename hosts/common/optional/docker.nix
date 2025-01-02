{
  virtualisation.docker = {
    enable = true;
  };

  networking.networkmanager.unmanaged = [ "interface-name:docker*" ];
}
