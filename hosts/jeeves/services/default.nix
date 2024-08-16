{
  imports = [
    ./servarr.nix
  ];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:escape_shifted_capslock";
      };
    };

    flatpak.enable = true;

    # devmon.enable = true;
    udisks2.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  console.useXkbConfig = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
