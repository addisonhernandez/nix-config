{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  networking.networkmanager.unmanaged = [ "interface-name:virbr*" ];
}
