{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    quickemu
    spice
  ];

  # allow usb redirection
  virtualisation.spiceUSBRedirection.enable = true;
  security.polkit.extraConfig =
    # javascript
    ''
      polkit.addRule(function (action, subject) {
        if (action.id == "org.spice-space.lowlevelusbaccess") {
          return polkit.Result.YES;
        }
      });
    '';
}
