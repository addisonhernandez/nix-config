{ pkgs, ... }:
{
  services = {
    samba = {
      enable = true;
      package = pkgs.sambaFull;
      openFirewall = true; # TCP: [ 139 445 ] UDP: [ 137 138 ]

      # Allow users in the samba group to share a directory from right-click menu
      usershares.enable = true;
    };

    # Make shares discoverable from Windows
    samba-wsdd = {
      enable = true;
      openFirewall = true; # TCP: [ 5357 ] UDP: [ 3702 ]
    };

    avahi = {
      enable = true;
      openFirewall = true; # UDP: [ 5353 ]
      nssmdns4 = true;
      publish.enable = true;
      publish.userServices = true;
    };
  };
}
