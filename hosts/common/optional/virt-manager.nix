{ pkgs, ... }:
{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;

    onBoot = "ignore"; # do not restart guests after host reboot
    onShutdown = "shutdown"; # on host shutdown, also shutdown running guests
    parallelShutdown = 2;

    # enable sharing host directories with a guest
    qemu.vhostUserPackages = with pkgs; [
      guestfs-tools
      virtiofsd
    ];
  };

  environment.systemPackages = with pkgs; [
    guestfs-tools
    virtiofsd
  ];

  networking.networkmanager.unmanaged = [ "interface-name:virbr*" ];
}
